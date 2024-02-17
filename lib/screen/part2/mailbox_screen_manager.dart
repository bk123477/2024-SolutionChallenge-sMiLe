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
    "새 우편이 도착했습니다! 3",
    "새 우편이 도착했습니다! 4",
    "새 우편이 도착했습니다! 5",
    "새 우편이 도착했습니다! 6",

    // ... 기타 알림
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로 가기 버튼 자동 생성 비활성화
        title: Center(
          child: Image.asset(
            'asset/img/smileimoge.png', // 중앙 이미지 경로
            height: 40,
          ),
        ),
        centerTitle: true, // 이미지를 AppBar의 중앙에 위치시킵니다.
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
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
}
