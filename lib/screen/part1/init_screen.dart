import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/depression_diagnosis_selection_screen.dart';
import 'package:smile_front/screen/part1/signin_screen.dart';
import 'package:smile_front/screen/part1/signup_screen2.dart';
import 'package:smile_front/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smile_front/screen/part2/home_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

GoogleSignIn googleSignIn = GoogleSignIn();
class _InitScreenState extends State<InitScreen> {
  bool _isSignInVisible = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  late String email;
  late String name;
  late int userScore;
  late List<String> medications;
  late bool _complete1;
  late bool _complete2;
  late bool _complete3;
  late bool _complete4;
  late bool _complete5;
  late bool _complete6;
  late int _mission1 ;
  late int _mission2 ;
  late int _mission3;
  late int _mission4;
  late int _mission5;
  late int _mission6;
  late String _dt1;
  late String _dt2;
  late String _dt3;
  late String _dt4;
  late String _dt5;
  late String _dt6;
  int flag = 0;

  @override
  void initState(){
    super.initState();
  }

  getUser() async {
    final DateTime now = DateTime.now();
    final String nowStr = DateFormat('yy-MM-dd').format(now);
    DocumentSnapshot _userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
    if (_userDoc.exists) {
      Map<String, dynamic> userData = _userDoc.data() as Map<String, dynamic>;
      email = userData['userInfo'];
      name = userData['userName'];
      userScore = userData['userScore'];
      medications = List<String>.from(userData['medications']);
      _complete1 = userData['complete1'] ?? false;
      _complete2 = userData['complete2'] ?? false;
      _complete3 = userData['complete3'] ?? false;
      _complete4 = userData['complete4'] ?? false;
      _complete5 = userData['complete5'] ?? false;
      _complete6 = userData['complete6'] ?? false;
      _mission1 = userData['mission1'] ?? 0;
      _mission2 = userData['mission2'] ?? 0;
      _mission3 = userData['mission3'] ?? 0;
      _mission4 = userData['mission4'] ?? 0;
      _mission5 = userData['mission5'] ?? 0;
      _mission6 = userData['mission6'] ?? 0;
      _dt1 = userData['dt1'] ?? "";
      _dt2 = userData['dt2'] ?? "";
      _dt3 = userData['dt3'] ?? "";
      _dt4 = userData['dt4'] ?? "";
      _dt5 = userData['dt5'] ?? "";
      _dt6 = userData['dt6'] ?? "";

      print(email);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('userInfo', email);
      _prefs.setString('userName', name);
      _prefs.setInt('userScore', userScore);
      _prefs.setStringList('medications', medications);
      // _prefs.setBool('complete1', _complete1);
      // _prefs.setBool('complete2', _complete2);
      // _prefs.setBool('complete3', _complete3);
      // _prefs.setBool('complete4', _complete4);
      // _prefs.setBool('complete5', _complete5);
      // _prefs.setBool('complete6', _complete6);
      print(nowStr);
      print(_dt1);
      if (nowStr == _dt1){
        _prefs.setBool('complete1', _complete1);
      } else {
        _prefs.setBool('complete1', false);
      }
      if (nowStr == _dt2){
        _prefs.setBool('complete2', _complete2);
      } else {
        _prefs.setBool('complete2', false);
      }
      if (nowStr == _dt3){
        _prefs.setBool('complete3', _complete3);
      } else {
        _prefs.setBool('complete3', false);
      }
      if (nowStr == _dt4){
        _prefs.setBool('complete4', _complete4);
      } else {
        _prefs.setBool('complete4', false);
      }
      if (nowStr == _dt5){
        _prefs.setBool('complete5', _complete5);
      } else {
        _prefs.setBool('complete5', false);
      }
      if (nowStr == _dt6){
        _prefs.setBool('complete6', _complete6);
      } else {
        _prefs.setBool('complete6', false);
      }
      _prefs.setString('dt1', _dt1);
      _prefs.setString('dt2', _dt2);
      _prefs.setString('dt3', _dt3);
      _prefs.setString('dt4', _dt4);
      _prefs.setString('dt5', _dt5);
      _prefs.setString('dt6', _dt6);
      _prefs.setInt('mission1', _mission1);
      _prefs.setInt('mission2', _mission2);
      _prefs.setInt('mission3', _mission3);
      _prefs.setInt('mission4', _mission4);
      _prefs.setInt('mission5', _mission5);
      _prefs.setInt('mission6', _mission6);
      flag = 1;
    } else {
      flag = 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Palette.bgColor,
      //   actions: <Widget>[
      //     AnimatedSwitcher(
      //       duration: const Duration(milliseconds: 300),
      //       transitionBuilder: (Widget child, Animation<double> animation) {
      //         return ScaleTransition(
      //           scale: animation,
      //           child: child,
      //         );
      //       },
      //       child: _isSignInVisible
      //           ? TextButton(
      //         key: ValueKey<String>('Sign In'),
      //         onPressed: () => setState(() {
      //           _isSignInVisible = false;
      //         }),
      //         child: Text('Sign In', style: TextStyle(color: Colors.white)),
      //       )
      //           : TextButton(
      //         key: ValueKey<String>('Sign Up'),
      //         onPressed: () => setState(() {
      //           _isSignInVisible = true;
      //         }),
      //         child: Text('Sign Up', style: TextStyle(color: Colors.white)),
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        color: Palette.bgColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 120.0, left: 40.0, right: 40.0),
                    child: Image.asset('asset/img/smileimoge.png', fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 120.0, left: 40.0, right: 40.0),
                    child: Image.asset('asset/img/smilelettering.png', fit: BoxFit.contain),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                      if (googleUser != null) {
                        email = googleUser.email;
                        name = email.split('@')[0];
                        print('name = ${googleUser.email}');
                        await getUser();
                        if (flag == 1){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                          );
                        }
                      } else{
                        SharedPreferences _prefs = await SharedPreferences.getInstance();
                        _prefs.setString('userInfo', email);
                        _prefs.setString('userName', email.split('@')[0]);
                        _prefs.setStringList('medications', ["예시: 비타민C",]);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DepressionDiagnosisSelectionScreen()),
                        );
                      }
                    },
                    icon: Image.asset('asset/img/glogo.png', height: 24.0),
                    label: Text(_isSignInVisible ? 'Start with Google' : 'Start with Google'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.white, width: 2),
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                SizedBox(height: 10), // 여기에 추가된 공간
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(
                    onPressed: _isSignInVisible ? _navtosignup : _navtosignin,
                    child: Text(_isSignInVisible ? 'Sign In' : 'Sign In'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.transparent, // 글자색을 흰색으로, 배경을 투명으로 설정
                      side: BorderSide(color: Colors.white, width: 2), // 테두리 색상 및 두께 설정
                      minimumSize: Size(double.infinity, 50), // 버튼 크기 설정
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // 모서리 둥글게 설정
                    ),
                  ),
                ),
                SizedBox(height: 30), // 여기에 추가된 공간
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navtosignin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
  }

  void _navtosignup() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
  }
}
