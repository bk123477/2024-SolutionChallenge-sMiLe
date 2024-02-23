import 'package:flutter/material.dart';
import '../../config/palette.dart';
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
      _userInfo = prefs.getString('email')?.split('@')[0] ?? 'User';
    });
    setState(() {
      _userScore = prefs.getInt('userScore')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset(
            'asset/img/smileimoge.png', // 앱바 중앙 이미지 경로. 실제 경로로 수정해주세요.
            height: 40,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_userInfo\'s Diagnosis Result', // 영어로 변경
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Palette.bgColor, // 텍스트 컬러 변경
                ),
              ),
              SizedBox(height: 20), // 텍스트 사이의 간격 추가
              Text(

                _userScore < 5 ? 'Minimal Depression ($_userScore)' :
                _userScore < 10 ? 'Mild Depression ($_userScore)' :
                _userScore < 15 ? 'Moderate Depression ($_userScore)' :
                _userScore < 20 ? 'Moderately Severe Depression ($_userScore)' :
                'Severe Depression ($_userScore)',
                style: TextStyle(
                  fontSize: 20, // 폰트 사이즈 증가
                  color: Colors.blueGrey, // 텍스트 컬러 변경
                ),
                textAlign: TextAlign.center, // 텍스트 정렬
              ),
              SizedBox(height: 30), // 버튼 전 간격 추가
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Palette.bgColor, // 버튼 내 텍스트 컬러 변경
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // 버튼 패딩 조절
                  textStyle: TextStyle(
                    fontSize: 18, // 버튼 텍스트 사이즈
                    fontWeight: FontWeight.bold, // 버튼 텍스트 굵기
                  ),
                  shape: RoundedRectangleBorder( // 버튼 모서리 둥글게
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),

    );
  }
}