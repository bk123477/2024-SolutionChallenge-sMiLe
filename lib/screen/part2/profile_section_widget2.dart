import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/init_screen.dart';
import 'package:smile_front/screen/part2/edit_profile_screen.dart';

class ProfileSectionWidget extends StatefulWidget{
  const ProfileSectionWidget({Key? key}) : super(key: key);

  @override
  _ProfileSectionWidgetState createState() => _ProfileSectionWidgetState();
}

class _ProfileSectionWidgetState extends State<ProfileSectionWidget> {
  String _userInfo = '';
  String _userName = '';
  late int _userScore = 0;
  late List<String> _medications;
  late int _mission1;
  late int _mission2;
  late int _mission3;
  late int _mission4;
  late int _mission5;
  late int _mission6;
  late bool _complete1;
  late bool _complete2;
  late bool _complete3;
  late bool _complete4;
  late bool _complete5;
  late bool _complete6;
  late String _dt1;
  late String _dt2;
  late String _dt3;
  late String _dt4;
  late String _dt5;
  late String _dt6;
  late String _userImage = "asset/img/smileimoge.png";

  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userInfo = prefs.getString('userInfo') ?? 'No User Info';
    });
    setState(() {
      _userName = prefs.getString('userName') ?? 'No User Info';
    });
    setState(() {
      _userScore = prefs.getInt('userScore')?? 0;
    });
    setState(() {
      _medications = prefs.getStringList('medications') ?? ['hi'];
    });
    setState(() {
      _mission1 = prefs.getInt('mission1') ?? 0;
    });
    setState(() {
      _mission2 = prefs.getInt('mission2') ?? 0;
    });
    setState(() {
      _mission3 = prefs.getInt('mission3') ?? 0;
    });
    setState(() {
      _mission4 = prefs.getInt('mission4') ?? 0;
    });
    setState(() {
      _mission5 = prefs.getInt('mission5') ?? 0;
    });
    setState(() {
      _mission6 = prefs.getInt('mission6') ?? 0;
    });
    setState(() {
      _complete1 = prefs.getBool('complete1') ?? false;
    });
    setState(() {
      _complete2 = prefs.getBool('complete2') ?? false;
    });
    setState(() {
      _complete3 = prefs.getBool('complete3') ?? false;
    });
    setState(() {
      _complete4 = prefs.getBool('complete4') ?? false;
    });
    setState(() {
      _complete5 = prefs.getBool('complete5') ?? false;
    });
    setState(() {
      _complete6 = prefs.getBool('complete6') ?? false;
    });
    setState(() {
      _dt1 = prefs.getString('dt1') ?? "";
    });
    setState(() {
      _dt2 = prefs.getString('dt2') ?? "";
    });
    setState(() {
      _dt3 = prefs.getString('dt3') ?? "";
    });
    setState(() {
      _dt4 = prefs.getString('dt4') ?? "";
    });
    setState(() {
      _dt5 = prefs.getString('dt5') ?? "";
    });
    setState(() {
      _dt6 = prefs.getString('dt6') ?? "";
    });
    setState(() {
      _userImage = prefs.getString('userImage') ?? "asset/img/smileimoge.png";
    });
  }

  _clearUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await FirebaseFirestore.instance
        .collection('users').doc(_userInfo).set({
      'userInfo': _userInfo,
      'userName': _userName,
      'userScore': _userScore,
      'medications': _medications,
      'mission1': _mission1,
      'mission2': _mission2,
      'mission3': _mission3,
      'mission4': _mission4,
      'mission5': _mission5,
      'mission6': _mission6,
      'complete1': _complete1,
      'complete2': _complete2,
      'complete3': _complete3,
      'complete4': _complete4,
      'complete5': _complete5,
      'complete6': _complete6,
      'dt1': _dt1,
      'dt2': _dt2,
      'dt3': _dt3,
      'dt4': _dt4,
      'dt5': _dt5,
      'dt6': _dt6,
      'userImage': _userImage,
    });
    prefs.clear();
    setState(() {
      _userInfo = "";
      _userName = "";
      _userScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getUserInfo();
    Widget imageWidget;

    if (_userImage == null || _userImage == "asset/img/smileimoge.png"){
      imageWidget = Image.asset(_userImage, fit: BoxFit.cover,);
    } else {
      imageWidget = Image.network(_userImage, fit: BoxFit.cover);
    }

    return Container(
      width: double.infinity, // 컨테이너 너비 확장
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // CircleAvatar(
          //   backgroundImage: AssetImage('asset/img/smileimoge.png'),
          //   radius: 40,
          // ),
          Container(
            width: 100,
            height: 100,
            child: ClipOval(
              child: imageWidget,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _userInfo,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Text(
            _userName,
            style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Score: ',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              Text(
                '$_userScore',
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(color: Colors.grey, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: _navtoedit,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit, color: Colors.black),
                        SizedBox(width: 8),
                        Text('Edit Profile', style: TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: InkWell(
                  onTap: () async {
                    _clearUserInfo();
                    _navtosignup();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width: 8),
                        Text('Logout', style: TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _navtosignup(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitScreen()));
  }

  void _navtoedit(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
  }

}