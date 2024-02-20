import 'package:flutter/material.dart';

class BadgeSectionWidget extends StatelessWidget {
  final List<Map<String, String>> badges;

  const BadgeSectionWidget({Key? key, required this.badges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 메인 뱃지는 리스트의 첫 번째 항목
    final Map<String, String> mainBadge = badges.first;
    // 최근 뱃지는 첫 번째 뱃지를 포함하여 최대 3개까지 표시
    final recentBadges = badges.take(3).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column( // Column 위젯으로 메인 뱃지와 최근 뱃지 영역을 세로로 배치
        children: [
          Text("Main Badge", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Center( // 메인 뱃지 중앙 배치
            child: _BadgeButton(context: context, badge: mainBadge),
          ),
          Divider(color: Colors.grey), // 구분선 추가
          Text("Recent Badges", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Wrap( // 최근 뱃지를 Wrap 위젯으로 배치하여 가로 방향으로 정렬
            spacing: 16, // 뱃지 사이의 가로 간격
            runSpacing: 16, // 뱃지 사이의 세로 간격
            alignment: WrapAlignment.center, // 뱃지들을 중앙 정렬
            children: recentBadges.map((badge) => _BadgeButton(context: context, badge: badge)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _BadgeButton({required BuildContext context, required Map<String, String> badge}) {
    return Container(
      width: 90, // Container와 내부 요소들의 너비를 조정
      child: Column(
        mainAxisSize: MainAxisSize.min, // 내용물에 따라 Column의 크기 조절
        children: [
          Container(
            width: 70, // 뱃지 이미지의 가로 크기
            height: 70, // 뱃지 이미지의 세로 크기
            decoration: BoxDecoration(
              color: Colors.white, // 배경색을 흰색으로 설정
              borderRadius: BorderRadius.circular(35), // 모서리를 둥글게 처리
            ),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return AlertDialog(
                      title: Text(badge["description"] ?? ""),
                      content: Image.asset(badge["image"] ?? ""),
                    );
                  },
                );
              },
              child: Image.asset(
                badge["image"] ?? "",
                width: 50, // 이미지 가로 크기 지정
                height: 50, // 이미지 세로 크기 지정
              ),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), backgroundColor: Colors.transparent, // 버튼 모서리를 완전히 둥글게 처리
                padding: EdgeInsets.all(10), // 버튼 배경색을 투명하게 설정
                elevation: 0, // 버튼 그림자 제거
              ),
            ),
          ),
          SizedBox(height: 8), // 이미지와 텍스트 사이의 간격
          Text(
            badge["description"] ?? "", // 뱃지 설명 텍스트
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14, // 텍스트 크기 조정
              color: Colors.black, // 텍스트 색상
            ),
          ),
        ],
      ),
    );
  }



}

