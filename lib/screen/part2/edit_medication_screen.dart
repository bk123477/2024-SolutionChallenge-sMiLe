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
    _medications = _prefs.getStringList('medications') ?? ['복용정보없음'];
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
        title: Text('돌아가기'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter medication',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addMedications,
                ),
              ),
              onSubmitted: (value) => _addMedications(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _medications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_medications[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _removeMedication(index),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(onPressed: (){
            _submit();
            _navtomypage();
          }, child: Text('수정 완료'))
        ],
      ),
    );
  }

  void _navtomypage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}