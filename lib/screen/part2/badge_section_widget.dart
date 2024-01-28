import 'package:flutter/material.dart';

class BadgeSectionWidget extends StatelessWidget {
  final List<Map<String, String>> badges;

  const BadgeSectionWidget({Key? key, required this.badges}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayedBadges = badges.take(6).toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center( // 중앙 정렬
        child: Wrap(
          spacing: 16, // 뱃지 사이의 가로 간격 증가
          runSpacing: 16, // 뱃지 사이의 세로 간격 증가
          alignment: WrapAlignment.center, // 뱃지들을 중앙 정렬
          children: displayedBadges.map((badge) => _BadgeButton(context: context, badge: badge)).toList(),
        ),
      ),
    );
  }

  Widget _BadgeButton({required BuildContext context, required Map<String, String> badge}) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(badge["description"] ?? ""),
              content: Image.network(badge["image"] ?? ""),
            );
          },
        );
      },
      child: Image.network(
        badge["image"] ?? "",
        width: 50,
        height: 50,
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
