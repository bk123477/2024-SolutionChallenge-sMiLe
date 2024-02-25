import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

import '../../config/palette.dart';

class LeaderboardScreenManager extends StatefulWidget {
  const LeaderboardScreenManager({Key? key}) : super(key: key);

  @override
  _LeaderboardScreenManagerState createState() =>
      _LeaderboardScreenManagerState();
}

class _LeaderboardScreenManagerState extends State<LeaderboardScreenManager> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _topUsers = [];
  late List<String> userImages = [];
  final List<String> missions = [
    "Looking at the sky",
    "Counting slowly  from 1 to 10",
    "Waking up early",
    "Stretching for a minute",
    "Listening to your favorite songs",
    "Not looking at my cell phone for an hour",
  ];
  List<bool> isChecked = List.filled(6, false);
  List<String> datetime = List.filled(6, "");
  int _selectedViewIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchUsers();
    _getUserMission();
  }

  _fetchUsers() async {
    leaderboards.clear();
    for (int i = 1; i <= 6; i++) {
      _fetchTopUsersForMission(i).then((_) {
        setState(() {
          leaderboards.add(_createLeaderboardWidget(_topUsers, i));
        });
      });
    }
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
    var snapshot = await _firestore
        .collection('users')
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

  final List<Widget> leaderboards = List.generate(
      6,
          (index) => Center(
        child: Text("${index + 1}"),
      ));


  Widget _createLeaderboardWidget(
      List<Map<String, dynamic>> topUsers, int missionNumber) {
    String missionName = missions[missionNumber - 1];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$missionName',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '\nTop Users',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(color: Colors.grey[300]),
        ...topUsers.asMap().entries.map((entry) {
          int idx = entry.key;
          Map user = entry.value;
          Widget _buildPhotoArea(){
            if (user['userImage'] == 'asset/img/smileimoge.png'){
              return Container(
                width: 50, height: 50,
                child: ClipOval(
                  child: Image.asset('asset/img/smileimoge.png', fit: BoxFit.cover,),
                ),
              );
            } else if (user['userImage'] != null) {
              return Container(
                width: 50, height: 50,
                child: ClipOval(
                  child: Image.network(user['userImage'], fit: BoxFit.cover),
                ),
              );
            } else {
              return Container(
                width: 50, height: 50,
                child: ClipOval(
                  child: Image.asset('asset/img/smileimoge.png', fit: BoxFit.cover),
                ),
              );
            }
          }

          return ListTile(
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPhotoArea(),
                SizedBox(width: 8),
                Text('#${idx + 1}',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
            title: Text(user['userName']),
            subtitle: Text('Score: ${user['mission${missionNumber}']}회'),
          );
        }).toList(),
      ],
    );
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24.0),
              border: Border.all(color: Palette.bgColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () => setState(() {
                          _selectedViewIndex = 0;
                        }),
                        child: Text(
                          'Mission',
                          style: TextStyle(
                            color: _selectedViewIndex == 0 ? Colors.white : Palette.bgColor,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedViewIndex == 0 ? Palette.bgColor : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: TextButton(
                        onPressed: () => setState(() {
                          _selectedViewIndex = 1;
                        }),
                        child: Text(
                          'Leaderboard',
                          style: TextStyle(
                            color: _selectedViewIndex == 1 ? Colors.white : Palette.bgColor,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: _selectedViewIndex == 1 ? Palette.bgColor : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _selectedViewIndex == 0
          ? _buildMissionsView()
          : _buildLeaderboardView(),
    );
  }

  Widget _buildMissionsView() {
    return ListView.builder(
      itemCount: missions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            '${index + 1}. ${missions[index]}',
            style: TextStyle(
              decoration: isChecked[index]
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          trailing: Checkbox(
            value: isChecked[index],
            onChanged: (value) async {
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              setState(() {
                isChecked[index] = value!;
                DateTime now = DateTime.now();
                datetime[index] = DateFormat('yy-MM-dd').format(now);
              });
              _prefs.setBool('complete${index + 1}', value!);
              if (value) {
                int tmp = _prefs.getInt('mission${index + 1}') ?? 0;
                _prefs.setInt('mission${index + 1}', tmp + 1);
                _prefs.setString('dt${index + 1}', datetime[index]);
              } else {
                int tmp = _prefs.getInt('mission${index + 1}') ?? 0;
                _prefs.setInt('mission${index + 1}', tmp - 1);
                _prefs.setString('dt${index + 1}', "");
              }
            },
            activeColor: Palette.bgColor,
          ),
        );
      },
    );
  }

  Widget _buildLeaderboardView() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: Center(
              child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.8,
                  keepPage: true,
                  initialPage: 60,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black),
                    ),
                    child: SingleChildScrollView(
                      child: leaderboards[index %
                          leaderboards.length],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MyToggleWidget extends StatefulWidget {
  @override
  _MyToggleWidgetState createState() => _MyToggleWidgetState();
}

class _MyToggleWidgetState extends State<MyToggleWidget> {
  int _selectedViewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(48.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.0),
          border: Border.all(color: Palette.bgColor),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                alignment: _selectedViewIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Palette.bgColor,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() {
                    _selectedViewIndex = 0;
                  }),
                  child: Text(
                    'Mission',
                    style: TextStyle(
                      color: _selectedViewIndex == 0 ? Colors.white : Palette.bgColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() {
                    _selectedViewIndex = 1;
                  }),
                  child: Text(
                    'Leaderboard',
                    style: TextStyle(
                      color: _selectedViewIndex == 1 ? Colors.white : Palette.bgColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

