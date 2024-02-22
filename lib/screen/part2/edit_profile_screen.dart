import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:smile_front/screen/part2/home_screen.dart'; // 경로는 프로젝트에 맞게 조정하세요.

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String _userName;
  late String _userInfo;
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker picker = ImagePicker();
  late String _userImage;

  Future<String?> uploadImage(XFile image, String userEmail) async {
    try {
      // 파일 이름 설정 (예: useremail_timestamp.jpg)
      String fileName = "${_userInfo}.jpg";

      // Firebase Storage에 업로드
      Reference ref = FirebaseStorage.instance.ref().child('userImages/$fileName');
      UploadTask uploadTask = ref.putFile(File(image.path));

      // 업로드 완료까지 기다림
      final TaskSnapshot snapshot = await uploadTask;
      // 업로드한 파일의 URL 가져오기
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _userImage = downloadUrl;
      print(_userImage);
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference docRef = firestore.collection('users').doc(_userInfo);
      await docRef.update({
        'userImage': _userImage,
      }).then((_){
        print("Document successfully updated!");
      });
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('userImage', downloadUrl);
      return downloadUrl;
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _userInfo = _prefs.getString('userInfo')!;
    });
  }
  setDefaultImage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _userImage = "asset/img/smileimoge.png";
      _prefs.setString('userImage', _userImage);
    });
  }

  editName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setString('userName', _userName);
    Navigator.pop(context); // 저장 후 이전 화면으로 돌아가기
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null){
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  Widget _buildPhotoArea(){
    if (_image != null) {
      return Container(
        width: 100, height: 100,
        child: ClipOval(
          child: Image.file(File(_image!.path)),
        ),
      );
    } else {
      return Container(
        width: 100, height: 100,
        child: ClipOval(
          child: Image.asset(
            'asset/img/smileimoge.png',
          ),
        ),
      );
    }
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
          height: MediaQuery.of(context).size.width, // 화면 너비의 85%
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Edit Image',
                    style: TextStyle(
                      fontSize: 24, // 크기를 키움
                      fontWeight: FontWeight.bold, // 볼드 처리
                    ),
                  ),
                  _buildPhotoArea(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: (){
                          getImage(ImageSource.gallery);
                        },
                        child: Text("사진 등록하기"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          setDefaultImage();
                        },
                        child: Text("기본 사진"),
                      )
                    ],
                  ),
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
                        uploadImage(_image!, _userInfo);
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
            )
          ),
        ),
      ),
    );
  }
}
