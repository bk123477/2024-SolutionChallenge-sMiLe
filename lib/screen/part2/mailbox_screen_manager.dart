import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/init_mail_screen.dart';
import 'package:smile_front/screen/part2/replymail_screen_manager.dart';

import '../../config/palette.dart';

class MailboxScreenManager extends StatefulWidget {
  const MailboxScreenManager({Key? key}) : super(key: key);

  @override
  _MailboxScreenManagerState createState() => _MailboxScreenManagerState();
}

class _MailboxScreenManagerState extends State<MailboxScreenManager> {
  final List<String> notifications = [
    "New mail has arrived! 1",
    "New mail has arrived! 2",
    "New mail has arrived! 3",
    "New mail has arrived! 4",
    "New mail has arrived! 5",
    "New mail has arrived! 6",
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
    resultData.forEach((key, value){
      senderInfo.add(key);
      senderMessage.add(resultData[key]!.last["message"]);
    });
    setState(() {});
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
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(4),
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
                _navtoinitmail();
              },
              child: Text('Send to Anonymous', style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.bgColor,
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
