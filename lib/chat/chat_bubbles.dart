import 'package:flutter/material.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, {Key? key}) : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    Widget bubble = Container(
      margin: EdgeInsets.only(top: isMe ? 10 : 4, bottom: 10, left: isMe ? 8 : 48, right: isMe ? 8 : 20), // 상대방 메시지일 경우 왼쪽 여백 조정
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white, // 모든 버블의 배경색을 흰색으로 통일
        border: Border.all(color: Colors.grey), // 테두리를 검은색으로 설정
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8), // 모서리를 덜 둥글게 조정
          topRight: Radius.circular(8),
          bottomLeft: isMe ? Radius.circular(8) : Radius.circular(0), // isMe에 따라 한 쪽 모서리를 사각지게 조정
          bottomRight: isMe ? Radius.circular(0) : Radius.circular(8),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.black), // 메시지 텍스트 색상을 검은색으로 설정
      ),
    );

    if (!isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('asset/img/bot_image.png'), // 프로필 이미지 경로
                radius: 16, // 원하는 크기로 조절
              ),
              SizedBox(width: 8),
              Text('sMiLe Bot', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          bubble, // 메시지 버블을 이름 밑에 배치
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [bubble],
      );
    }
  }
}
