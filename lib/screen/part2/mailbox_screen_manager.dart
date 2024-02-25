import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/init_mail_screen.dart';
import 'package:smile_front/screen/part2/replymail_screen_manager.dart';

class MailboxScreenManager extends StatefulWidget {
  const MailboxScreenManager({Key? key}) : super(key: key);

  @override
  _MailboxScreenManagerState createState() => _MailboxScreenManagerState();
}

class _MailboxScreenManagerState extends State<MailboxScreenManager> {
  final List<String> notifications = [
    "새 우편이 도착했습니다! 1",
    "새 우편이 도착했습니다! 2",
    "새 우편이 도착했습니다! 3",
    "새 우편이 도착했습니다! 4",
    "새 우편이 도착했습니다! 5",
    "새 우편이 도착했습니다! 6",

    // ... 기타 알림
  ];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String myName;
  late List<String> senderInfo = [];
  late List<String> senderMessage = [];

  @override
  void initState(){
    super.initState();
    _getMyInfo();
  }

  _getMyInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    myName = _prefs.getString('userInfo')!;
    setState(() {});
    _fetchMail();
  }

  _fetchMail() async {
    var result = await _firestore.collection('messages')
        .doc(myName).get();
    Map<String, dynamic> resultData = result.data() as Map<String, dynamic>;
    // var keys = resultData.keys;
    // print(keys.toList());
    resultData.forEach((key, value){
      senderInfo.add(key);
      senderMessage.add(resultData[key]!.last["message"]);
    });
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            'asset/img/smileimoge.png',
            height: 40,
          )
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.separated(
              itemCount: senderInfo.length,
              itemBuilder: (context, index){
                return Card(
                  color: Colors.white, // 카드 배경색을 흰색으로 설정
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1), // 회색 테두리
                    borderRadius: BorderRadius.circular(4), // 테두리 둥글게
                  ),
                  child: ListTile(
                    title: Center(child: Text(notifications[index], style: TextStyle(color: Colors.grey))),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReplymailScreenManager(senderInfo: senderInfo[index], senderMessage: senderMessage[index])),
                      );
                    },
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // 익명 상대에게 보내기 기능 구현
                _navtoinitmail();
              },
              child: Text('익명 상대에게 보내기', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey, // 버튼 배경색을 회색으로 설정
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _navtoinitmail(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => InitMailScreen()));
  }
}
