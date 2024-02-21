import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LeaderboardScreenManager extends StatefulWidget {
  const LeaderboardScreenManager({Key? key}) : super(key: key);

  @override
  _LeaderboardScreenManagerState createState() => _LeaderboardScreenManagerState();
}

class _LeaderboardScreenManagerState extends State<LeaderboardScreenManager> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _topUsers = [];
  final List<String> missions = [
    "하늘 보기", "1부터 10까지 천천히 숫자 세기", "일찍 일어나기", "1분간 스트레칭", "좋아하는 노래 듣기", "1시간 동안 휴대폰 보지 않기"
  ];
  List<bool> isChecked = List.filled(6, false);
  List<String> datetime = List.filled(6, "");

  @override
  void initState() {
    super.initState();
    leaderboards.clear();
    for (int i=1; i<=6; i++){
      _fetchTopUsersForMission(i).then((_){
        setState(() {
          leaderboards.add(_createLeaderboardWidget(_topUsers, i));
        });
      });
    }
    _getUserMission();

  }

  void _getUserMission() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    isChecked[0] = _prefs.getBool('complete1') ?? false;
    isChecked[1] = _prefs.getBool('complete2') ?? false;
    isChecked[2] = _prefs.getBool('complete3') ?? false;
    isChecked[3] = _prefs.getBool('complete4') ?? false;
    isChecked[4] = _prefs.getBool('complete5') ?? false;
    isChecked[5] = _prefs.getBool('complete6') ?? false;
  }

  _fetchTopUsersForMission(int missionNumber) async {
    String missionField = 'mission${missionNumber}';
    var snapshot = await _firestore.collection('users')
    .orderBy(missionField, descending: true)
    .limit(5)
    .get();

    List<Map<String, dynamic>> topUsers = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> userData = doc.data() as Map<String, dynamic>;
      topUsers.add(userData);
    });
    setState(() {
      _topUsers = topUsers;
    });
  }

  final List<Widget> leaderboards = List.generate(6, (index) => Center(
    child: Text("${index+1}"),
  ));

  Widget _createLeaderboardWidget(List<Map<String, dynamic>> topUsers, int missionNumber){
    String missionName = missions[missionNumber-1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text('${missionName}\n Top Users', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ),
        ...topUsers.asMap().entries.map((entry){
          int idx = entry.key;
          Map user = entry.value;
          return ListTile(
            leading: Text('#${idx + 1}등', style: TextStyle(fontWeight: FontWeight.bold)),
            title: Text(user['userName']),
            subtitle: Text('Score: ${user['mission${missionNumber}']}회'),
          );
        }).toList(),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    SharedPreferences _prefs;
    return Scaffold(
      appBar: AppBar(
        title: Text('미션 및 리더보드'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: missions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                      '${index+1}. ${missions[index]}',
                    style: TextStyle(
                      decoration: isChecked[index] ? TextDecoration.lineThrough : TextDecoration.none,
                    )
                  ),
                  trailing: Checkbox(
                    value: isChecked[index],
                    onChanged: (value) async {
                      setState(() {
                        isChecked[index] = value!;
                        DateTime now = DateTime.now();
                        datetime[index] = DateFormat('yy-MM-dd').format(now);
                      });
                      _prefs = await SharedPreferences.getInstance();
                      _prefs.setBool('complete${index+1}', value!);
                      if (value){
                        int tmp = _prefs.getInt('mission${index+1}') ?? 0;
                        _prefs.setInt('mission${index+1}', tmp+1);
                        _prefs.setString('dt${index+1}', datetime[index]);
                      } else {
                        int tmp = _prefs.getInt('mission${index+1}') ?? 0;
                        _prefs.setInt('mission${index+1}', tmp-1);
                        _prefs.setString('dt${index+1}', "");
                      }
                    },
                  )
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.blue[100],
              child: Center(
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemBuilder: (context, index) {
                    List<Color> colors = [Colors.blue[100]!, Colors.green[100]!, Colors.red[100]!, Colors.yellow[100]!];
                    // return leaderboards[index % leaderboards.length];
                    if (leaderboards.isEmpty){
                      return Center(child: Text('Loading...'),);
                    }
                    else {
                      return Container(
                        color: colors[index % colors.length],
                        child: SingleChildScrollView(
                          child: leaderboards[index % leaderboards.length],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


}