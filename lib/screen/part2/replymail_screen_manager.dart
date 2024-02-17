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
          automaticallyImplyLeading: false, // 기본 뒤로 가기 버튼 비활성화
          leading: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Back',
              style: TextStyle(
                color: Colors.black, // AppBar 텍스트 색상과 일치시키기
              ),
            ),
          ),
          title: Center(
            child: Image.asset(
              'asset/img/smileimoge.png', // 앱바 중앙 이미지 경로. 실제 경로로 수정해주세요.
              height: 40,
            ),
          ),
          actions: [
            Opacity(
              opacity: 0.0, // 시각적 균형을 위한 더미 위젯
              child: TextButton(
                onPressed: () {},
                child: Text('Back'),
              ),
            ),
          ],
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
