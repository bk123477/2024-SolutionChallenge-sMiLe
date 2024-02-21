import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeSectionWidget extends StatelessWidget {
  final List<Map<String, String>> badges;
  final List<int> missions;

  const BadgeSectionWidget({Key? key, required this.badges, required this.missions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayedBadges = badges.take(6).toList();
    final displayMissions = missions.take(6).toList();

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
          children: List.generate(displayedBadges.length, (index){
            return _BadgeButton(context: context, badge: displayedBadges[index], missionsCount: displayMissions[index]);
          }),
          // children: displayedBadges.map((badge) => _BadgeButton(context: context, badge: badge, missions: displayMissions)).toList(),
        ),
      ),
    );
  }

  Widget _BadgeButton({required BuildContext context, required Map<String, String> badge, required int missionsCount}) {

    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Column(
                children: [
                  Text(badge["description"] ?? "", style: TextStyle(
                    fontSize: 20,
                  ),),
                  Text('총 ${missionsCount}회 달성'),
                ],
              ),
              content: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Image.asset(badge["image"]!, fit: BoxFit.contain)
                ],
              )
            );
          },
        );
      },
      child: Image.asset(badge["image"]!, width: 70, height: 70, fit: BoxFit.contain),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
