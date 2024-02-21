import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/home_screen.dart';

class EditProfileScreen extends StatefulWidget{
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String _userName;
  final _formKey = GlobalKey<FormState>();


  editName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userName', _userName);
    print(_userName);
    print(_prefs.getString('userName'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("돌아가기"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  '이름 수정하기', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '수정하고자 하는 사용자 이름을 입력하세요.',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? false){
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _userName = value ?? "";
                  },
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: (){
                  if(_formKey.currentState?.validate() ?? false){
                    _formKey.currentState?.save();
                    editName();
                    _navtomypage();
                  }
                }, child: Text('수정하기')),
              ],
            )
          )
        ],
      )
    );
  }

  void _navtomypage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}