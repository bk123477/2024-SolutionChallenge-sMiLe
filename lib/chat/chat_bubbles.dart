import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBubbles extends StatelessWidget {
  const ChatBubbles(this.message, this.isMe, this.time,{Key? key}) : super(key: key);

  final String message;
  final bool isMe;
  final Timestamp time;

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width * 0.8; // 화면 너비의 80%로 최대 너비 설정

    // Timestamp를 DateTime으로 변환
    DateTime dateTime = time.toDate();

    // DateTime을 일, 시간, 분만 포함하는 문자열로 포맷팅
    String formattedTime = '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';

    Widget bubble = Column(
       crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start, // Column의 자식들을 왼쪽 정렬
      children: [
        Container(
          margin: EdgeInsets.only(top: isMe ? 4 : 4, bottom: 1, left: isMe ? 8 : 8, right: isMe ? 10 : 10),
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
        ),
        Row(
          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start, // isMe 값에 따라 위치 조정
          children: [
            Container(
              margin: isMe ? EdgeInsets.only(right: 10) : EdgeInsets.only(left: 10), // isMe에 따라 마진 조정
              child: Text(
                formattedTime,
                style: TextStyle(color: Colors.grey, fontSize: 12), // 시간 표시 스타일 조정
              ),
            ),
          ],
        ),

      ],
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
        children: [
          bubble,
          
        ],
      );
    }
  }

}
