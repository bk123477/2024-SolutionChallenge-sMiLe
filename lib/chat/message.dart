import 'package:flutter/material.dart';
import 'chat_bubbles.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 예시 데이터 - 실제로는 서버에서 데이터를 가져와야 합니다.
    //TODO: 채팅 상위 위젯에서 전달받기
    var chatDocs = [
      {'text': '안녕하세요!', 'isMe': true},
      {'text': '안녕하세요, 어떻게 도와드릴까요?', 'isMe': false},
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
