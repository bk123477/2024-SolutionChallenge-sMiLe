import 'package:flutter/material.dart';

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
        title: Text('우울증 진단 방법 선택'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('진단 방법을 선택하세요'),
            ),
            ElevatedButton(
              onPressed: _navigateToChecklistDiagnosis,
              child: Text('체크리스트로 진단하기'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToChatbotDiagnosis,
              child: Text('챗봇과 대화하며 진단하기'),
            ),
          ],
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatbotConsentScreen()),
    );// 챗봇 대화 진단 페이지로 이동
  }
}
