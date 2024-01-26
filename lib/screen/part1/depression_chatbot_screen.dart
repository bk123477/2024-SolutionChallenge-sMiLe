import 'package:flutter/material.dart';
import '../../chat/message.dart';
import '../../chat/new_message.dart';

class DepressionChatbotScreen extends StatefulWidget {
  const DepressionChatbotScreen({Key? key}) : super(key: key);

  @override
  State<DepressionChatbotScreen> createState() => _DepressionChatbotScreenState();
}

class _DepressionChatbotScreenState extends State<DepressionChatbotScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('채팅을 통한 우울증 진단'),

      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),  // 메시지 목록을 표시합니다.
            ),
            NewMessage(),  // 새 메시지 입력 필드를 표시합니다.
          ],
        ),
      ),
    );
  }
}
