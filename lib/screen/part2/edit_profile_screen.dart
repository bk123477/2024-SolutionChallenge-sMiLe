import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/home_screen.dart'; // 경로는 프로젝트에 맞게 조정하세요.

class EditProfileScreen extends StatefulWidget {
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
    Navigator.pop(context); // 저장 후 이전 화면으로 돌아가기
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
            'asset/img/smileimoge.png', // 실제 이미지 경로로 수정해주세요.
            height: 40,
          ),
        ),
        actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85, // 화면 너비의 85%
          height: MediaQuery.of(context).size.width * 0.5, // 화면 너비의 85%
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20), // 모서리 둥글게
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  'Edit Name',
                  style: TextStyle(
                    fontSize: 24, // 크기를 키움
                    fontWeight: FontWeight.bold, // 볼드 처리
                  ),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: '수정하고자 하는 사용자 이름을 입력하세요.',
                    border: OutlineInputBorder(),

                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  onSaved: (value) => _userName = value ?? "",
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      editName();
                    }
                  },
                  child: Text('수정하기'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white, // 버튼 텍스트 색상
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
