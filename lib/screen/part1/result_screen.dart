import 'package:flutter/material.dart';
import '../part2/home_screen.dart';

class ResultScreen extends StatelessWidget {
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text('새싹단계 (1)', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('떡잎단계 (2)', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('성장단계 (3)', style: TextStyle(fontSize: 18)),
            SizedBox(height: 30),
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
