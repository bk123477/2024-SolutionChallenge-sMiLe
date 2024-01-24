import 'package:flutter/material.dart';
import '../../chat/message.dart';
import '../../chat/new_message.dart';

class DailydialogueChatbotScreen extends StatefulWidget {
  final VoidCallback onToggleScreen;
  const DailydialogueChatbotScreen({Key? key, required this.onToggleScreen}) : super(key: key);


  @override
  State<DailydialogueChatbotScreen> createState() => _DailydialogueChatbotScreenState();
}

class _DailydialogueChatbotScreenState extends State<DailydialogueChatbotScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
          onPressed: () => widget.onToggleScreen(),

          child: Text(
            '일상대화',
            style: TextStyle(
              color: Colors.black,  // AppBar의 배경색과 대비되도록 색상 지정
              fontSize: 18,
            ),
          ),
        ),
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
