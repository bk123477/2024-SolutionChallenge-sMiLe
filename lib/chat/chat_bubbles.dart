import 'package:flutter/material.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, {Key? key}) : super(key: key);

  final String message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.8; // 화면 너비의 80%로 최대 너비 설정

    Widget bubble = Container(
      margin: EdgeInsets.only(top: isMe ? 10 : 4, bottom: 10, left: isMe ? 8 : 48, right: isMe ? 8 : 10),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      constraints: BoxConstraints(maxWidth: maxWidth), // 여기에 최대 너비 제한 추가
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: isMe ? Radius.circular(8) : Radius.circular(0),
          bottomRight: isMe ? Radius.circular(0) : Radius.circular(8),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.black),
      ),
    );

    if (!isMe) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('asset/img/bot_image.png'),
                radius: 16,
              ),
              SizedBox(width: 8),
              Text('Leni', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          bubble,
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
