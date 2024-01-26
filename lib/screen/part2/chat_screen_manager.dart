import 'package:flutter/material.dart';
import 'dailydialogue_chatbot_widget.dart';
import 'emotiontrashbin_chatbot_widget.dart';

class ChatScreenManager extends StatefulWidget {
  const ChatScreenManager({Key? key}) : super(key: key);

  @override
  _ChatScreenManagerState createState() => _ChatScreenManagerState();
}

class _ChatScreenManagerState extends State<ChatScreenManager> {
  bool isDailyDialogueScreen = true; // 현재 활성화된 스크린 플래그

  void toggleScreen() {
    setState(() {
      isDailyDialogueScreen = !isDailyDialogueScreen; // 스크린 전환
    });
  }

  @override
  Widget build(BuildContext context) {
    return isDailyDialogueScreen
        ? DailydialogueChatbotWidget(onToggleScreen: toggleScreen)
        : EmotiontrashbinChatbotWidget(onToggleScreen: toggleScreen);
  }
}
