import 'package:flutter/material.dart';
import '../part2/home_screen.dart';
import '../../config/palette.dart'; // Palette 클래스를 정의한 파일을 임포트합니다.

class ResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white, // AppBar 아이콘 색상을 흰색으로 설정
        ),
        title: Image.asset(
          'asset/img/smilelettering.png',
          height: 40.0, // 이미지 높이 조절
        ),
        centerTitle: true,
      ),
      backgroundColor: Palette.bgColor, // 배경색을 Palette 클래스의 bgColor로 설정
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('새싹단계 (1)', style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 10),
            Text('떡잎단계 (2)', style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 10),
            Text('성장단계 (3)', style: TextStyle(fontSize: 18, color: Colors.white)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Palette.bgColor, // 버튼 글씨 색상을 흰색으로 설정
                side: BorderSide(color: Colors.white, width: 2), // 버튼의 테두리를 흰색으로 설정
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // 버튼 모서리를 둥글게 처리
              ),
              child: Text('확인'),
            ),
          ],
        ),
      ),
    );
  }
}
