import 'package:flutter/material.dart';

class ReplymailScreenManager extends StatefulWidget {
  const ReplymailScreenManager({Key? key}) : super(key: key);

  @override
  _ReplymailScreenManagerState createState() => _ReplymailScreenManagerState();
}

class _ReplymailScreenManagerState extends State<ReplymailScreenManager> {
  final TextEditingController _replyController = TextEditingController();

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
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  '우편 내용이 여기 표시됩니다.', // 실제 우편 내용으로 대체
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: TextField(
                controller: _replyController,
                decoration: InputDecoration(labelText: '답장을 입력하세요'),
                maxLines: null, // 여러 줄 입력 가능
              ),
            ),
          ],
        ),
      ),
    );
  }
}
