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
      _userScore = prefs.getInt('userScore')!;
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
    });
    prefs.clear();
    setState(() {
      _userInfo = "";
      _userName = "";
      _userScore = 0;
    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity, // 컨테이너 너비 확장
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            radius: 40,
          ),
          Text(_userInfo),
          Text(_userName),
          Text('${_userScore}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  _navtoedit();
                },
                child: Text('Edit Profile'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // print(_userName);
                  _clearUserInfo();
                  _navtosignup();
                },
                child: Text('Logout'),
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