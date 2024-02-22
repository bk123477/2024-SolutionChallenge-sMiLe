import 'package:flutter/material.dart';

import '../../config/palette.dart';
import 'chatbot_consent_screen.dart';
import 'depression_checklist_screen2.dart';

class DepressionDiagnosisSelectionScreen extends StatefulWidget {
  const DepressionDiagnosisSelectionScreen({Key? key}) : super(key: key);

  @override
  State<DepressionDiagnosisSelectionScreen> createState() => _DepressionDiagnosisSelectionScreenState();
}

class _DepressionDiagnosisSelectionScreenState extends State<DepressionDiagnosisSelectionScreen> {
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
        child: Container(
          width: 300, // 컨테이너의 너비 설정
          height: 300, // 컨테이너의 높이 설정
          decoration: BoxDecoration(
            color: Colors.white, // 컨테이너 배경색을 흰색으로 설정
            border: Border.all(color: Colors.black, width: 2), // 컨테이너 테두리를 검은색으로 설정
            borderRadius: BorderRadius.circular(12), // 컨테이너 모서리를 둥글게 처리
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // 자식 위젯을 수평 중앙에 배치
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Please select a method for depression diagnosis.', // 메시지 영어로 번역
                  style: TextStyle(
                    color: Colors.black, // 텍스트 색상을 검은색으로 설정
                    fontWeight: FontWeight.bold, // 볼드 처리
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center, // 텍스트를 중앙 정렬
                ),
              ),

              Divider(
                color: Colors.black, // 구분선의 색상 설정
                height: 60, // 구분선의 높이 설정 (위 아래의 패딩 포함)
                thickness: 2, // 구분선의 두께 설정
                indent: 20, // 구분선의 시작 부분에 여백 추가
                endIndent: 20, // 구분선의 끝 부분에 여백 추가

              ),
              ElevatedButton(
                onPressed: _navigateToChecklistDiagnosis,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Palette.bgColor, // 버튼 텍스트 색상을 흰색으로 설정
                ),
                child: Text('Diagnose with Checklist'), // 버튼 텍스트 영어로 번역
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navigateToChatbotDiagnosis,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Palette.bgColor, // 버튼 텍스트 색상을 흰색으로 설정
                ),
                child: Text('Diagnose with Chatbot'), // 버튼 텍스트 영어로 번역
              ),
            ],
          ),
        ),
      ),


    );
  }

  void _navigateToChecklistDiagnosis() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DepressionChecklistScreen()),
    );// 체크리스트 진단 페이지로 이동
  }

  void _navigateToChatbotDiagnosis() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ChatbotConsentScreen()),
    // );// 챗봇 대화 진단 페이지로 이동

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sorry, chatbot diagnosis is not yet implemented. Please use the checklist method.'),
        duration: Duration(seconds: 5), // 스낵바를 5초간 표시

      ),
    );
  }


}
