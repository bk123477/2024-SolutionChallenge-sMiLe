import 'package:flutter/material.dart';
import '../../chat/message_send.dart';  // 실제 경로에 맞게 수정해주세요.
import '../../chat/message_show.dart';  // 실제 경로에 맞게 수정해주세요.

class EmotiontrashbinChatbotWidget extends StatefulWidget {
  final VoidCallback onToggleScreen;
  const EmotiontrashbinChatbotWidget({Key? key, required this.onToggleScreen}) : super(key: key);

  @override
  State<EmotiontrashbinChatbotWidget> createState() => _EmotiontrashbinChatbotWidgetState();
}

class _EmotiontrashbinChatbotWidgetState extends State<EmotiontrashbinChatbotWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // 뒤로 가기 버튼 자동 생성 비활성화
        title: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 요소들을 양 끝으로 정렬
              children: <Widget>[
                TextButton(
                  onPressed: widget.onToggleScreen,
                  style: TextButton.styleFrom(
                    primary: Colors.black, // 텍스트 색상
                  ),
                  child: Text(
                    'Emotional Outlet',
                    style: TextStyle(
                      fontSize: 16, // 텍스트 크기
                    ),
                  ),
                ),
                // AppBar 중앙에 이미지를 위치시키기 위해 Row의 중앙에 배치
                Image.asset(
                  'asset/img/smileimoge.png', // 중앙 이미지 경로
                  height: 40,
                ),
                // 시각적 균형을 위한 더미 위젯
                Opacity(
                  opacity: 0.0,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Emotional Outlet',
                      style: TextStyle(
                        fontSize: 16, // 동일한 텍스트 크기
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
