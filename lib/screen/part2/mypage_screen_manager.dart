import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/badge_section_widget2.dart';
import 'profile_section_widget2.dart';
import 'medication_section_widget.dart';

class MypageScreenManager extends StatefulWidget {
  const MypageScreenManager({Key? key}) : super(key: key);

  @override
  _MypageScreenManagerState createState() => _MypageScreenManagerState();
}

class _MypageScreenManagerState extends State<MypageScreenManager> {
  late String userInfo;
  late String userName;
  late int userScore;
  late List<String> medications = [];
  late int mission1;
  late int mission2;
  late int mission3;
  late int mission4;
  late int mission5;
  late int mission6;
  late List<int> missions = [];

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userInfo = prefs.getString('userInfo') ?? 'No user info';
    userName = prefs.getString('userName')!;
    userScore = prefs.getInt('userScore')!;
    medications = prefs.getStringList('medications') ?? ['복용 정보 없음'];
    mission1 = prefs.getInt('mission1')!;
    mission2 = prefs.getInt('mission2')!;
    mission3 = prefs.getInt('mission3')!;
    mission4 = prefs.getInt('mission4')!;
    mission5 = prefs.getInt('mission5')!;
    mission6 = prefs.getInt('mission6')!;
    missions.add(mission1);
    missions.add(mission2);
    missions.add(mission3);
    missions.add(mission4);
    missions.add(mission5);
    missions.add(mission6);
    // print(userInfo);
    // print(missions);
  }

  final List<Map<String, String>> badges = [
    {"image": "asset/img/sky.png", "description": "하늘 보기"},
    {"image": "asset/img/number.png", "description": "1부터 10까지 천천히 숫자세기"},
    {"image": "asset/img/sleep.png", "description": "일찍 일어나기"},
    {"image": "asset/img/stretching.png", "description": "1분간 스트레칭"},
    {"image": "asset/img/sing.png", "description": "좋아하는 노래 듣기"},
    {"image": "asset/img/smartphone.png", "description": "1시간 동안 휴대폰 보지 않기"},
  ];


  @override
  void initState(){
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(
          child: Image.asset(
            'asset/img/smileimoge.png', // 앱바 중앙 이미지 경로. 실제 경로로 수정해주세요.
            height: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionTitle("Badge"),
            // BadgeSectionWidget(badges: badges, missions: missions),
            BadgeSectionWidget(),
            SizedBox(height: 20),
            _buildSectionTitle("Profile"),
            ProfileSectionWidget(),
            SizedBox(height: 20),
            _buildSectionTitle("Medication Information"),
            MedicationSectionWidget(medications: medications),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
