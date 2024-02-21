import 'package:flutter/material.dart';
import '../part2/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreenWidget extends StatefulWidget{
  const ResultScreenWidget({Key? key}) : super(key: key);

  @override
  _ResultScreenWidgetState createState() => _ResultScreenWidgetState();
}

class _ResultScreenWidgetState extends State<ResultScreenWidget> {
  int _userScore = 0;
  String _userInfo = '';

  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userInfo = prefs.getString('email')!.split('@')[0] ?? 'No User Info';
    });
    setState(() {
      _userScore = prefs.getInt('userScore')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('우울증 진단 결과'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              '${_userInfo}님의 진단 결과 입니다.', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            // Text('새싹단계 (1)', style: TextStyle(fontSize: 18)),
            // SizedBox(height: 10),
            // Text('떡잎단계 (2)', style: TextStyle(fontSize: 18)),
            // SizedBox(height: 10),
            // Text('성장단계 (3)', style: TextStyle(fontSize: 18)),
            // SizedBox(height: 30),
            Text(
              _userScore < 5 ? '${_userScore} Minimal Depression' :
                  _userScore < 10 ? '${_userScore} Mild Depression' :
                      _userScore < 15 ? '${_userScore} Moderate Depression' :
                          _userScore < 20 ? '${_userScore} Moderately Severe Depression' :
                              '${_userScore} Severe Depression',
              style: TextStyle(fontSize: 15),
            ),
            ElevatedButton(
              onPressed: () {
                // HomeScreen으로 이동하고, 뒤로 가기로 결과 화면으로 돌아오지 못하게 함
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}