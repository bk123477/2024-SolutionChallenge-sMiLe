import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/init_screen.dart';
import 'package:smile_front/config/palette.dart';
import 'package:smile_front/screen/part2/home_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Future<void> _checkLoginStatus() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String? _userInfo = _prefs.getString('userInfo');

    if(_userInfo != null){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => InitScreen()));
    }
  }


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      _checkLoginStatus();
    });
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => InitScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Palette.bgColor, // 배경색 설정
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 120.0, left: 40.0, right: 40.0),
                child: Image.asset('asset/img/smileimoge.png', fit: BoxFit.contain), // 상단 이미지
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 120.0, left: 40.0, right: 40.0),
                child: Image.asset('asset/img/smilelettering.png', fit: BoxFit.contain), // 하단 이미지
              ),
            ),
          ],
        ),
      ),
    );
  }
}
