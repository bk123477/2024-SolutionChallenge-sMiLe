import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/depression_diagnosis_selection_screen.dart';
import 'package:smile_front/screen/part1/signin_screen.dart';
import 'package:smile_front/screen/part1/signup_screen2.dart';
import 'package:smile_front/config/palette.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

GoogleSignIn googleSignIn = GoogleSignIn();
class _InitScreenState extends State<InitScreen> {
  bool _isSignInVisible = true;
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bgColor,
        actions: <Widget>[
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                scale: animation,
                child: child,
              );
            },
            child: _isSignInVisible
                ? TextButton(
              key: ValueKey<String>('Sign In'),
              onPressed: () => setState(() {
                _isSignInVisible = false;
              }),
              child: Text('Sign In', style: TextStyle(color: Colors.white)),
            )
                : TextButton(
              key: ValueKey<String>('Sign Up'),
              onPressed: () => setState(() {
                _isSignInVisible = true;
              }),
              child: Text('Sign Up', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
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
                        print('name = ${googleUser.email}');
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.clear();
                        prefs.setString('email', googleUser.email);
                        print(prefs.get('email'));
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DepressionDiagnosisSelectionScreen()),
                      );
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
                    child: Text(_isSignInVisible ? 'Sign Up' : 'Sign In'),
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
