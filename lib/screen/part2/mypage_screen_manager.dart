import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/badge_section_widget.dart';
import 'profile_section_widget.dart';
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
    mission1 = prefs.getInt('mission1') ?? 0;
    mission2 = prefs.getInt('mission2') ?? 0;
    mission3 = prefs.getInt('mission3') ?? 0;
    mission4 = prefs.getInt('mission4') ?? 0;
    mission5 = prefs.getInt('mission5') ?? 0;
    mission6 = prefs.getInt('mission6') ?? 0;
    missions.add(mission1);
    missions.add(mission2);
    missions.add(mission3);
    missions.add(mission4);
    missions.add(mission5);
    missions.add(mission6);
  }

  final List<Map<String, String>> badges = [
    {"image": "asset/img/sky.png", "description": "Looking at the sky",},
    {"image": "asset/img/number.png", "description": "Counting slowly  from 1 to 10"},
    {"image": "asset/img/sleep.png", "description": "Waking up early"},
    {"image": "asset/img/stretching.png", "description": "Stretching for a minute"},
    {"image": "asset/img/sing.png", "description": "Listening to your favorite songs"},
    {"image": "asset/img/smartphone.png", "description": "Not looking at my cell phone for an hour"},
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
            'asset/img/smileimoge.png',
            height: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSectionTitle("Badge"),
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
