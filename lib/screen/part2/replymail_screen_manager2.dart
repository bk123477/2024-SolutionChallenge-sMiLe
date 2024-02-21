import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplymailScreenManager extends StatefulWidget {
  final String senderInfo;
  final String senderMessage;

  const ReplymailScreenManager({Key? key, required this.senderInfo, required this.senderMessage}) : super(key: key);

  @override
  _ReplymailScreenManagerState createState() => _ReplymailScreenManagerState();
}

class _ReplymailScreenManagerState extends State<ReplymailScreenManager> {
  final TextEditingController _replyController = TextEditingController();
  late String myName;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState(){
    super.initState();
    _getMyInfo();
  }

  _getMyInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    myName = _prefs.getString('userInfo')!;
  }

  void _sendMessage() async {
    final message = _replyController.text;
    DateTime now = DateTime.now();

    if (message.isNotEmpty) {
      _firestore.collection('messages').doc(myName).update({
        widget.senderInfo: FieldValue.delete(),
      }).then((_){
        _firestore.collection('messages').doc(widget.senderInfo).set({
          '${myName}': FieldValue.arrayUnion([{
            'message': message,
            'datetime': now,
          }]),
        }, SetOptions(merge: true));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // 다른 곳을 탭하면 키보드 숨김
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('우편 답장하기'),
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                "나에게 온 편지",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  widget.senderMessage, // 실제 우편 내용으로 대체
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Center(
              child: Text(
                "답장 내용",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )
              )
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  _replyController.text, // 미리보기
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      decoration: InputDecoration(labelText: '답장을 입력하세요'),
                      onChanged: (text){
                        setState(() {});
                      },
                      maxLines: null, // 여러 줄 입력 가능
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      _sendMessage();
                      _navtomailbox();
                    },
                    icon: Icon(Icons.send),
                  )
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  void _navtomailbox(){
    Navigator.pop(context);
  }
}
