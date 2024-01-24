import 'package:flutter/material.dart';
import '../screen/part2/dailydialogue_chatbot_screen.dart'; // DailydialogueChatbotScreen import
import '../screen/part2/emotiontrashbin_chatbot_screen.dart'; // EmotiontrashbinChatbotScreen import

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
        ? DailydialogueChatbotScreen(onToggleScreen: toggleScreen)
        : EmotiontrashbinChatbotScreen(onToggleScreen: toggleScreen);
  }
}
