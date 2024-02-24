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
  int _selectedViewIndex = 0; // 0 for missions, 1 for leaderboard

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
                    color: Colors.black, // 모던하고 심플한 느낌을 위한 색상 선택
                  ),
                ),
                TextSpan(
                  text: '\nTop Users',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54, // 부드러운 대조를 위해 더 어두운 색상 사용
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
              mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞춤
              children: [
                // CircleAvatar(
                //   // 여기에 적절한 이미지가 있다면 넣어주세요, 없다면 기본 아이콘을 사용
                //   backgroundImage: AssetImage(
                //       'asset/img/smileimoge.png'), // 실제 이미지 경로로 변경해주세요.
                //   // 이미지가 없을 때 주석을 해제하고 기본 아이콘을 사용할 수 있습니다.
                //   // child: Icon(Icons.person),
                // ),
                _buildPhotoArea(),
                SizedBox(width: 8), // CircleAvatar와 텍스트 사이 간격
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
            preferredSize: Size.fromHeight(48.0), // 토글 버튼의 높이 지정
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0), // 좌우 마진 추가
              decoration: BoxDecoration(
                color: Colors.white, // 배경색 설정
                borderRadius: BorderRadius.circular(24.0), // 모서리를 둥글게 처리
                border: Border.all(color: Palette.bgColor), // 경계선 색상 설정
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0), // 자식 위젯의 모서리를 둥글게 처리
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0), // 여기에 좌우 마진 적용
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
                              borderRadius: BorderRadius.circular(24.0), // 모서리 처리를 부모에서 처리
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0), // 여기에 좌우 마진 적용
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
                              borderRadius: BorderRadius.circular(24.0), // 모서리 처리를 부모에서 처리
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
            activeColor: Palette.bgColor, // 체크됐을 때의 색상을 Palette.bgColor로 설정
          ),
        );
      },
    );
  }

  Widget _buildLeaderboardView() {
    return Container(
      width: double.infinity,
      color: Colors.white, // 배경색 설정
      child: Column(
        children: [
          SizedBox(height: 10), // 리더보드 위에 20픽셀의 여백을 추가합니다.
          Expanded(
            // Expanded를 사용하여 PageView가 남은 공간을 모두 차지하도록 합니다.
            child: Center(
              child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.8, // 각 페이지가 화면 너비의 80%만 차지하도록 설정
                  keepPage: true, // 페이지 간격 유지
                  initialPage: 60,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    // 각 페이지 사이의 가로 간격 추가
                    decoration: BoxDecoration(
                      color: Colors.white, // 컨테이너 속 색상을 흰색으로 설정
                      borderRadius: BorderRadius.circular(20), // 모서리를 둥글게 설정
                      border: Border.all(color: Colors.black), // 검은색 테두리 추가
                    ),
                    child: SingleChildScrollView(
                      child: leaderboards[index %
                          leaderboards.length], // 여기서 리스트의 길이로 나눈 나머지를 사용합니다.
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
  int _selectedViewIndex = 0; // 선택된 뷰의 인덱스를 추적

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(48.0), // 토글 버튼의 높이 지정
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0), // 좌우 마진 추가
        decoration: BoxDecoration(
          color: Colors.white, // 배경색 설정
          borderRadius: BorderRadius.circular(24.0), // 모서리를 둥글게 처리
          border: Border.all(color: Palette.bgColor), // 경계선 색상 설정
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0), // 자식 위젯의 모서리를 둥글게 처리
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AnimatedContainer를 사용하여 선택된 버튼에 따라 배경이 부드럽게 이동하도록 함
              AnimatedContainer(
                duration: Duration(milliseconds: 300), // 애니메이션 지속 시간
                curve: Curves.easeInOut, // 애니메이션 곡선
                alignment: _selectedViewIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4, // 전체 너비의 약 40% 크기로 설정
                  height: 40, // 높이는 40으로 고정
                  decoration: BoxDecoration(
                    color: Palette.bgColor,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
              // 미션 버튼
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
              // 리더보드 버튼
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

