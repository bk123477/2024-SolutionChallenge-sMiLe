import 'package:flutter/material.dart';
import 'chat_bubbles.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 데이터 - 실제로는 서버에서 데이터를 가져와야 합니다.
    //TODO: 채팅 상위 위젯에서 전달받기
    var chatDocs = [
      {'text': "I've tried, but nothing seems to work. It just makes me more frustrated.", 'isMe': true},
      {'text': "Sleep disturbances can be challenging. Have you tried any methods to improve your sleep?", 'isMe': false},
      {'text': "I've been having trouble sleeping, and it's affecting my daily life.", 'isMe': true},
      {'text': "It’s completely okay to feel that way. Can you tell me what's been on your mind lately?", 'isMe': false},
      {'text': "I'm feeling a bit overwhelmed and anxious, to be honest.", 'isMe': true},
      {'text': "Good morning, how are you feeling today?", 'isMe': false},
    ];

    return ListView.builder(
      reverse: true,
      itemCount: chatDocs.length,
      itemBuilder: (context, index) => ChatBubbles(
        chatDocs[index]['text'] as String,
        chatDocs[index]['isMe'] as bool,
      ),
    );

  }
}
