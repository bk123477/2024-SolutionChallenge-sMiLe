import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/result_screen2.dart';

import '../../config/palette.dart';

class DepressionChecklistScreen extends StatefulWidget {
  const DepressionChecklistScreen({Key? key}) : super(key: key);

  @override
  _DepressionChecklistScreenState createState() => _DepressionChecklistScreenState();
}

class _DepressionChecklistScreenState extends State<DepressionChecklistScreen> {

  late int finalScore = 0;

  // 체크리스트 데이터 - 예시
  final List<String> symptoms = [
    "Little interest or pleasure in doing things ",
    "Feeling down, depressed, or hopeless.",
    "Trouble falling or staying asleep, or sleeping too much",
    "Feeling tired or having little energy",
    "Poor appetite or overeating",
    "Feeling bad about yourself - or that you are a failure or have let yourself or your family down",
    "Trouble concentrating on things, such as reading the newspaper or watching television",
    "Moving or speaking so slowly that other people could have noticed Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual",
    "Thoughts that you would be better off dead, or of hurting yourself",
    "If you checked off any problems, how difficult have these problems made it for you at work, home, or with other people?",
  ];


  @override
  void initState() {
    super.initState();
    // 모든 증상에 대해 체크 상태 초기화
  }

  Map<int, int> scores = {}; // 각 증상의 점수를 저장하는 맵

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
            'asset/img/smileimoge.png', // 실제 이미지 경로로 수정해주세요.
            height: 40,
          ),
        ),
        actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '${index + 1}. ${symptoms[index]}',
                        style: TextStyle(
                          fontSize: 15, // 글씨 크기 증가
                          fontWeight: FontWeight.bold, // 글씨 굵게
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2, // 2열
                      childAspectRatio: 3, // 자식 위젯의 가로세로 비율
                      crossAxisSpacing: 4, // 열 사이 간격
                      mainAxisSpacing: 4, // 행 사이 간격
                      shrinkWrap: true, // 내부 컨텐츠에 맞게 크기 조정
                      physics: NeverScrollableScrollPhysics(), // ListView 내부 스크롤 문제 해결
                      children: List.generate(4, (optionIndex) => ListTile(
                        title: Text(_getOptionText(optionIndex)),
                        leading: Radio<int>(
                          value: optionIndex,
                          groupValue: scores[index],
                          onChanged: (int? value) {
                            setState(() {
                              scores[index] = value!;
                            });
                          },
                          activeColor: Palette.bgColor, // 체크될 때 색상을 검은색으로 설정
                        ),
                      )),
                    ),
                  ],
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              finalScore = scores.values.reduce((a, b) => a + b); // 모든 점수를 합산
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('userScore', finalScore);
              print(finalScore);
              _navtoresult();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Palette.bgColor, // 버튼 텍스트 색상을 흰색으로 설정
              textStyle: TextStyle(
                fontSize: 16, // 텍스트 크기 설정 (선택적)
              ),
            ),
            child: Text('Submit and check score'),
          ),

        ],
      ),
    );
  }

  String _getOptionText(int index) {
    switch (index) {
      case 0:
        return 'Never';
      case 1:
        return 'Sometimes';
      case 2:
        return 'Usually';
      case 3:
        return 'Always';
      default:
        return '';
    }
  }

  void _navtoresult() {
    // 체크리스트 제출 로직
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreenWidget()), // 가상의 결과 스크린
    );
  }
}
