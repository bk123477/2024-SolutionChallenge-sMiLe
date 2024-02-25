import 'package:flutter/material.dart';

import '../../config/palette.dart';
import 'chatbot_consent_screen.dart';
import 'depression_checklist_screen.dart';

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
            'asset/img/smileimoge.png',
            height: 40,
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  'Please select a method for depression diagnosis.',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              Divider(
                color: Colors.black,
                height: 60,
                thickness: 2,
                indent: 20,
                endIndent: 20,

              ),
              ElevatedButton(
                onPressed: _navigateToChecklistDiagnosis,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Palette.bgColor,
                ),
                child: Text('Diagnose with Checklist'),
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
    );
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
