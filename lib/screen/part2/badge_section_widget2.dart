import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BadgeSectionWidget extends StatefulWidget{
  const BadgeSectionWidget({Key? key}) : super(key: key);

  @override
  _BadgeSectionWidgetState createState() => _BadgeSectionWidgetState();
}

class _BadgeSectionWidgetState extends State<BadgeSectionWidget> {
  List<String> _badges = [
    'asset/img/sky.png',
    'asset/img/number.png',
    'asset/img/sleep.png',
    'asset/img/stretching.png',
    'asset/img/sing.png',
    'asset/img/smartphone.png',
  ];
  final List<String> _description = [
    "하늘 보기", "1부터 10까지 천천히 숫자 세기", "일찍 일어나기", "1분간 스트레칭", "좋아하는 노래 듣기", "1시간 동안 휴대폰 보지 않기"
  ];
  late int mission1;
  late int mission2;
  late int mission3;
  late int mission4;
  late int mission5;
  late int mission6;

  late List<int> _missionCount;


  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  Future<int?> _getUserInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    print(_prefs.getInt('mission1'));
  }

  @override
  Widget build(BuildContext context){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          alignment: WrapAlignment.center,
          children: [
            ...List.generate(_badges.length, (index){
              return _BadgeButton(context: context, index: index);
            }),
          ],
        ),
      ),
    );
  }

  Widget _BadgeButton({required BuildContext context, required int index}){
    return ElevatedButton(
      onPressed: () async {
        SharedPreferences _prefs = await SharedPreferences.getInstance();
        String key = 'mission'+'${index+1}';
        print(_prefs.getInt(key));
        int mission = _prefs.getInt(key)!;
        showDialog(
          context: context,
          builder: (BuildContext dialogContext){
            return AlertDialog(
              title: Column(
                children: [
                  Text(_description[index] ?? "", style: TextStyle(
                    fontSize: 20,
                  ),),
                  Text('총 ${mission}회 달성'),
                ],
              ),
              content: Stack(
                children: <Widget>[
                  Image.asset(_badges[index]!, fit: BoxFit.contain)
                ],
              ),
            );
          }
        );
      },
      child: Image.asset(_badges[index]!, width: 70, height: 70, fit: BoxFit.contain),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }



}