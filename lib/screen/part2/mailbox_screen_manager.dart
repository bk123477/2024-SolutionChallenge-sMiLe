import 'package:flutter/material.dart';
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
    // ... 기타 알림
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 우체통'),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[300],
                  child: ListTile(
                    title: Center(child: Text(notifications[index])),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReplymailScreenManager()),
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
              },
              child: Text('익명 상대에게 보내기'),
            ),
          ),
        ],
      ),
    );
  }
}
