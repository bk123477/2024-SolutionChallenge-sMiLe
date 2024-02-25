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
  late String _beforeName;
  late String _userInfo;
  final _formKey = GlobalKey<FormState>();
  XFile? _image;
  final ImagePicker picker = ImagePicker();
  late String _userImage = "asset/img/smileimoge.png";

  Future<String?> uploadImage(XFile image, String userEmail) async {
    try {
      String fileName = "${_userInfo}.jpg";

      Reference ref = FirebaseStorage.instance.ref().child('userImages/$fileName');
      UploadTask uploadTask = ref.putFile(File(image.path));


      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _userImage = downloadUrl;
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
  Future<String?> uploadBasicImage(String src, String userEmail) async {
    try{
      String fileName = "${_userInfo}.jpg";
      Reference ref = FirebaseStorage.instance.ref().child('userImages/$fileName');
      UploadTask uploadTask = ref.putFile(File('asset/img/smileimoge.png'));

      final TaskSnapshot snapshot = await uploadTask;

      final String downloadUrl = await snapshot.ref.getDownloadURL();
      _userImage = downloadUrl;
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
      _userName = _prefs.getString('userName')!;
      _beforeName = _userName!;
      _userImage = _prefs.getString('userImage')!;
    });
  }
  setDefaultImage() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      _userImage = "asset/img/smileimoge.png";
      _prefs.setString('userImage', _userImage);
    });
    _image = null;
  }

  editName() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_userName == "" || _userName == null){
      _userName = _beforeName;
    }
    _prefs.setString('userName', _userName);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef = firestore.collection('users').doc(_userInfo);
    await docRef.update({
      'userName': _userName,
      'userImage': _userImage,
    }).then((_){
      print("Document successfully updated!");
    });
    Navigator.pop(context);
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
    if (_image != null ){
      return Container(
        width: 100, height: 100,
        child: ClipOval(
          child: Image.file(File(_image!.path), fit: BoxFit.cover,),
        ),
      );
    } else {
      if (_userImage == null) {
        return Container(
          width: 100, height: 100,
          child: ClipOval(
            child: Image.asset('asset/img/smileimoge.png', fit: BoxFit.cover,),
          ),
        );
      } else {
        if (_userImage == 'asset/img/smileimoge.png'){
          return Container(
            width: 100, height: 100,
            child: ClipOval(
              child: Image.asset(_userImage, fit: BoxFit.cover,),
            ),
          );
        }
        else {
          return Container(
            width: 100, height: 100,
            child: ClipOval(
              child: Image.network(_userImage, fit: BoxFit.cover,),
            ),
          );
        }
      }
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
            'asset/img/smileimoge.png',
            height: 40,
          ),
        ),
        actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          height: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
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
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
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
                        child: Text("Upload Image"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: (){
                          setDefaultImage();
                        },
                        child: Text("Default Image"),
                      )
                    ],
                  ),
                  Text(
                    'Edit Name',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Please enter the name of the user you want to modify',
                      border: OutlineInputBorder(),

                    ),
                    onSaved: (value){
                      if (value == null){
                        value = _userName;
                      }
                      _userName = value;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        _formKey.currentState?.save();
                        editName();
                        if (_image == null) {
                          uploadBasicImage(_userImage, _userInfo);
                        } else {
                          uploadImage(_image!, _userInfo);
                        }
                      }
                    },
                    child: Text('Modify'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.white,
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
