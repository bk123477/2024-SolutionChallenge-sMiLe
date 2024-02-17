import 'package:flutter/material.dart';
import 'package:smile_front/screen/part1/result_screen.dart';
import '../../config/palette.dart'; // Palette 설정이 포함된 경로를 확인해주세요.

class DepressionChecklistScreen extends StatefulWidget {
  const DepressionChecklistScreen({Key? key}) : super(key: key);

  @override
  _DepressionChecklistScreenState createState() => _DepressionChecklistScreenState();
}

class _DepressionChecklistScreenState extends State<DepressionChecklistScreen> {
  final List<String> symptoms = [
    "일상 활동에 대한 관심 상실",
    "지속적인 우울한 기분",
    "수면 장애",
    "피로감 또는 에너지 상실",
  ];
  final List<bool> checked = [];

  @override
  void initState() {
    super.initState();
    checked.addAll(List.generate(symptoms.length, (index) => false));
  }

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
          'asset/img/smilelettering.png', // 앱바에 들어갈 이미지 경로
          height: 40.0, // 이미지 높이 조절
        ),
        centerTitle: true,
      ),
      backgroundColor: Palette.bgColor, // 배경색 설정
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('진단 체크리스트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
          ),
          ...symptoms.map((symptom) => CheckboxListTile(
            value: checked[symptoms.indexOf(symptom)],
            onChanged: (bool? value) {
              setState(() {
                checked[symptoms.indexOf(symptom)] = value!;
              });
            },
            title: Text(symptom, style: TextStyle(color: Colors.white)),
            checkColor: Palette.bgColor, // 체크박스 내부 색상
            activeColor: Colors.white, // 체크박스 외부 색상
            controlAffinity: ListTileControlAffinity.leading, // 체크박스를 텍스트 앞으로 이동
            side: BorderSide(color: Colors.white), // 체크박스 테두리 색상
          ))
              .toList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20.0),
            child: ElevatedButton(
              onPressed: _submitChecklist,
              child: Text('제출하고 점수 확인하기', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                side: BorderSide(color: Colors.white, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitChecklist() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreen()),
    );
  }
}
