import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatefulWidget {
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late String _userInfo = "";

  @override
  void initState(){
    super.initState();
    getUser();
    print(_userInfo);
  }

  Future<String?>getUser() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('userInfo');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final _userInfo = snapshot.data;
        // null 체크
        if (_userInfo == null) {
          return Center(child: Text("No user info found"));
        }

        var chatDocs = _firestore
            .collection('chat')
            .where('userInfo', isEqualTo: _userInfo)
            .orderBy('time', descending: true)
            .snapshots();

        return Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: chatDocs,
                builder: (context, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
                  if (chatSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final chatDocsList = chatSnapshot.data?.docs ?? [];
                  return ListView.builder(
                    reverse: true,
                    itemCount: chatDocsList.length,
                    itemBuilder: (context, index) =>
                        ChatBubbles(
                          chatDocsList[index]['chat'],
                          chatDocsList[index]['isUser'],
                          chatDocsList[index]['time'],
                        ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
  }
