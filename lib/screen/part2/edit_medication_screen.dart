import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/home_screen.dart';

class EditMedicationScreen extends StatefulWidget{

  const EditMedicationScreen({Key? key}) : super(key: key);

  @override
  _EditMedicationScreenState createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _medications = [];
  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _medications = _prefs.getStringList('medications') ?? ['No Medications Info'];
    setState(() {
      _medications = _medications;
    });
  }

  void _addMedications(){
    if (_controller.text.isNotEmpty) {
      setState(() {
        _medications.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _removeMedication(int index) {
    setState(() {
      _medications.removeAt(index);
    });
  }

  void _submit() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList('medications', _medications);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Back', style: TextStyle(color: Colors.black)),
        ),
        title: Center(
          child: Image.asset(
            'asset/img/smileimoge.png',
            height: 40,
          ),
        ),
        actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter medication',
                labelStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: Colors.black),
                  onPressed: _addMedications,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),

              onSubmitted: (value) => _addMedications(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _medications.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(_medications[index], style: TextStyle(color: Colors.blueGrey)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeMedication(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _submit();
                _navtomypage();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.black),
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              ),
              child: Text('Submit Changes'),
            ),
          ),
        ],
      )
    );
  }

  void _navtomypage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}