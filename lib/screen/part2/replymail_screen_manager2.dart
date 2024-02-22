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
          automaticallyImplyLeading: false,
          leading: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Back', style: TextStyle(color: Colors.black)),
          ),
          title: Center(
            child: Image.asset(
              'asset/img/smileimoge.png', // 실제 이미지 경로로 수정해주세요.
              height: 40,
            ),
          ),
          actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Letter to me",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/img/mail.png'),
                          fit: BoxFit.cover
                        )
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          widget.senderMessage, // 실제 우편 내용으로 대체
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                      child: Text(
                          "Content Preview",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )
                      )
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('asset/img/mail.png'),
                          fit: BoxFit.cover,
                        )
                      ),
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          _replyController.text, // 미리보기
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _replyController,
                      decoration: InputDecoration(
                          labelText: 'Enter a reply',
                        border: OutlineInputBorder(),
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      keyboardType: TextInputType.multiline,
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
