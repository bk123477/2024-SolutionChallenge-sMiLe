import 'package:flutter/material.dart';

class DepressionChecklistScreen extends StatefulWidget {
  const DepressionChecklistScreen({Key? key}) : super(key: key);

  @override
  _DepressionChecklistScreenState createState() => _DepressionChecklistScreenState();
}

class _DepressionChecklistScreenState extends State<DepressionChecklistScreen> {
  // 체크리스트 데이터 - 예시
  final List<String> symptoms = [
    "일상 활동에 대한 관심 상실",
    "지속적인 우울한 기분",
    "수면 장애",
    "피로감 또는 에너지 상실",
    // ... 기타 증상들
  ];
  final List<bool> checked = []; // 체크 상태를 추적하는 리스트

  @override
  void initState() {
    super.initState();
    // 모든 증상에 대해 체크 상태 초기화
    checked.addAll(List.generate(symptoms.length, (index) => false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('진단 체크리스트'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('진단 체크리스트', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          for (int i = 0; i < symptoms.length; i++)
            CheckboxListTile(
              value: checked[i],
              onChanged: (bool? value) {
                setState(() {
                  checked[i] = value!;
                });
              },
              title: Text(symptoms[i]),
            ),
          ElevatedButton(
            onPressed: _submitChecklist,
            child: Text('제출하고 점수 확인하기'),
          ),
        ],
      ),
    );
  }

  void _submitChecklist() {
    // 체크리스트 제출 로직
  }
}
