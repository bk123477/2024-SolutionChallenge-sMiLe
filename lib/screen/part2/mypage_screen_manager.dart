import 'package:flutter/material.dart';
import 'badge_section_widget.dart';
import 'profile_section_widget.dart';
import 'medication_section_widget.dart';

class MypageScreenManager extends StatefulWidget {
  const MypageScreenManager({Key? key}) : super(key: key);

  @override
  _MypageScreenManagerState createState() => _MypageScreenManagerState();
}

class _MypageScreenManagerState extends State<MypageScreenManager> {
  final List<Map<String, String>> badges = [
    {"image": "https://via.placeholder.com/150", "description": "뱃지 1"},
    {"image": "https://via.placeholder.com/150", "description": "뱃지 2"},
    {"image": "https://via.placeholder.com/150", "description": "뱃지 3"},
    {"image": "https://via.placeholder.com/150", "description": "뱃지 4"},
    {"image": "https://via.placeholder.com/150", "description": "뱃지 5"},
    {"image": "https://via.placeholder.com/150", "description": "뱃지 6"},
    {"image": "https://via.placeholder.com/150", "description": "뱃지 7"},
  ];

  final List<String> medications = [
    "아침: 아스피린 100mg",
    "점심: 비타민 C 500mg",
    "저녁: 오메가3 1000mg",
    "자기 전: 멜라토닌 5mg",
    "주 3회: 철분 보충제 10mg",
    "필요시: 파라세타몰 500mg",
    "매일: 칼슘 200mg + 비타민 D",
    "매일: 프로바이오틱스 1캡슐",
    "아침: 항알레르기제 10mg",
    "저녁: 당뇨병 치료제 500mg",
    "아침: 고혈압 약 50mg",
    "저녁: 콜레스테롤 관리제 20mg",
    "주 2회: 비타민 B12 주사",
    "필요시: 항산화제 보충제",
    "매일: 마그네슘 400mg",
    "주 1회: 철분 주사 100mg",
    "아침: 갑상선 호르몬제 25mcg",
    "점심: 피부 보호제 500mg",
    "저녁: 소염제 100mg",
    "자기 전: 수면 유도제 50mg"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionTitle("Badge", "더보기 >"),
            BadgeSectionWidget(badges: badges),
            SizedBox(height: 20),
            ProfileSectionWidget(),
            SizedBox(height: 20),
            MedicationSectionWidget(medications: medications),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20)),
          TextButton(
            onPressed: () {},
            child: Text(actionText),
          ),
        ],
      ),
    );
  }
}
