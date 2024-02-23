import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/mailbox_screen_manager.dart';

class InitMailScreen extends StatefulWidget {
  const InitMailScreen({Key? key}) : super(key: key);
  @override
  _InitMailScreenState createState() => _InitMailScreenState();
}

class _InitMailScreenState extends State<InitMailScreen> {
  final _messageController = TextEditingController();
  late List<String> userInfoList;
  late String myName;
  late String selectedUser = "";

  @override
  void initState(){
    super.initState();
    _getMyInfo();
    _fetchUser();
  }

  _selectRandomUser() {
    final random = Random();
    while (true) {
      int randomIndex = random.nextInt(userInfoList.length);
      if (myName != userInfoList[randomIndex]){
        selectedUser = userInfoList[randomIndex];
            break;
      }
    }
  }

  _getMyInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    myName = _prefs.getString('userInfo')!;
  }

  _fetchUser() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('users').get();
    List<Map<String, dynamic>> allUsersInfo = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    userInfoList = allUsersInfo.map((user) => user['userInfo'].toString()).toList();
    _selectRandomUser();
    print(selectedUser);
  }

  void _sendMessage() async {
    final message = _messageController.text;
    print(myName);
    DateTime now = DateTime.now();

    if (message.isNotEmpty) {
      // FirebaseFirestore.instance.collection('messages').doc(myName).set({
      //   selectedUser: FieldValue.arrayUnion([{
      //     'sender': myName,
      //     'message': message,
      //     'datetime': now,
      //   }]),
      // }, SetOptions(merge: true));
      FirebaseFirestore.instance.collection('messages').doc(selectedUser).set({
        '${myName}': FieldValue.arrayUnion([{
          'message': message,
          'datetime': now,
        }]),
      },SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Send to Anonymous'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _messageController.text,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      maxLines: null,
                      decoration: InputDecoration(labelText: 'Please enter a message'),
                      onChanged: (text) {
                        setState(() {});
                      },
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
          ),
        ],
        // children: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: Column(
        //       children: [
        //         Expanded(
        //           child: Text(
        //             _messageController.text,
        //             style: TextStyle(fontSize: 18),
        //           ),
        //         ),
        //         SizedBox(height: 20,),
        //         Expanded(
        //           child: TextField(
        //             controller: _messageController,
        //             maxLines: null,
        //             decoration: InputDecoration(labelText: '메시지를 입력하세요.'),
        //           ),
        //         ),
        //         IconButton(
        //             onPressed: _sendMessage,
        //             icon: Icon(Icons.send)
        //         )
        //       ],
        //     ),
        //   ),
        // ],
      ),
    );
  }

  void _navtomailbox(){
    Navigator.pop(context);
  }
}