import 'package:flutter/material.dart';

import './depression_chatbot_screen.dart';

class ChatbotConsentScreen extends StatelessWidget {
  const ChatbotConsentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('챗봇과의 대화 시작'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '이 대화는 챗봇과의 상호작용을 개선하기 위해 수집될 수 있습니다. 모든 데이터는 익명으로 처리되며 개인정보 보호에 최선을 다하고 있습니다.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _agreeAndStartChat(context),
              child: Text('동의 후 시작'),
            ),
          ],
        ),
      ),
    );
  }

  void _agreeAndStartChat(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DepressionChatbotScreen()),
    );// 챗봇 대화 진단 페이지로 이동
  }
}
