import 'package:flutter/material.dart';
import '../../chat/message.dart';
import '../../chat/new_message.dart';

class DailydialogueChatbotWidget extends StatefulWidget {
  final VoidCallback onToggleScreen;
  const DailydialogueChatbotWidget({Key? key, required this.onToggleScreen}) : super(key: key);

  @override
  State<DailydialogueChatbotWidget> createState() => _DailydialogueChatbotWidgetState();
}

class _DailydialogueChatbotWidgetState extends State<DailydialogueChatbotWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로 가기 버튼 자동 생성 비활성화
        title: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              width: constraints.maxWidth, // AppBar의 최대 너비를 사용
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, // 요소들을 양 끝으로 정렬
                children: <Widget>[
                  TextButton(
                    onPressed: widget.onToggleScreen,
                    style: TextButton.styleFrom(
                      primary: Colors.black, // 텍스트 색상
                    ),
                    child: Text(
                      'Daily Life',
                      style: TextStyle(
                        fontSize: 16, // 텍스트 크기
                      ),
                    ),
                  ),
                  Image.asset(
                    'asset/img/smileimoge.png', // 중앙 이미지 경로
                    height: 40,
                  ),
                  Opacity(
                    opacity: 0.0, // 눈에 보이지 않는 더미 위젯으로 균형 유지
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Daily Life',
                        style: TextStyle(
                          fontSize: 16, // 동일한 텍스트 크기
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(), // 메시지 목록을 표시합니다.
            ),
            NewMessage(), // 새 메시지 입력 필드를 표시합니다.
          ],
        ),
      ),
    );
  }
}
