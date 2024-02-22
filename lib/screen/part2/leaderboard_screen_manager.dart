import 'package:flutter/material.dart';
import 'dart:math';

// 유저 데이터를 담을 클래스 정의
class UserData {
  final String name;
  final String profileImageUrl;
  final int wins;

  UserData(this.name, this.profileImageUrl, this.wins);
}

class LeaderboardScreenManager extends StatefulWidget {
  @override
  _LeaderboardScreenManagerState createState() => _LeaderboardScreenManagerState();
}

class _LeaderboardScreenManagerState extends State<LeaderboardScreenManager> {
  final List<String> tasks = ["task1", "task2", "task3"];

  // 각 종목별 유저 데이터 리스트
  final Map<String, List<UserData>> taskUsers = {
    "task1": [
      UserData("유저1", "asset/img/smileimoge.png", 10),
      UserData("유저2", "asset/img/smileimoge.png", 9),
      UserData("유저3", "asset/img/smileimoge.png", 5),
      UserData("유저4", "asset/img/smileimoge.png", 3),
      UserData("유저5", "asset/img/smileimoge.png", 1),
      // 추가 유저 데이터...
    ],
    "task2": [
      UserData("유저1", "asset/img/smileimoge.png", 10),
      UserData("유저2", "asset/img/smileimoge.png", 9),
      UserData("유저3", "asset/img/smileimoge.png", 7),
      // 추가 유저 데이터...
    ],
    "task3": [
      UserData("유저1", "asset/img/smileimoge.png", 6),
      UserData("유저3", "asset/img/smileimoge.png", 5),
      // 추가 유저 데이터...
    ],
  };

  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
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
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: tasks.map((task) => _buildTaskPage(task)).toList(),
            ),
          ),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildTaskPage(String task) {
    List<UserData> users = taskUsers[task] ?? [];
    return Center( // 박스를 중앙에 위치시키기 위해 Center 위젯 사용
      child: Container(
        width: double.infinity, // 화면 너비에 맞춤
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white, // 배경색을 흰색으로 설정
          border: Border.all(color: Colors.grey, width: 2), // 검은색 테두리 추가
          borderRadius: BorderRadius.circular(10), // 모서리를 둥글게 처리
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // 내용물에 맞게 높이 조절
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.yellow.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ), // 상단 모서리만 둥글게 처리
              ),
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.center,
              child: Text(task, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            ListView.builder(
              shrinkWrap: true, // ListView가 차지하는 공간을 내용물 크기에 맞게 조절
              physics: NeverScrollableScrollPhysics(), // 스크롤 동작 비활성화
              itemCount: min(users.length, 5), // 최대 5명까지만 표시
              itemBuilder: (context, index) {
                UserData user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(user.profileImageUrl),
                  ),
                  title: Text(user.name, style: TextStyle(fontSize: 16)),
                  trailing: Text('${user.wins}회 승리', style: TextStyle(color: Colors.grey)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildPageIndicator() {
    String prevTask = _currentPage > 0 ? tasks[_currentPage - 1] : '';
    String nextTask = _currentPage < tasks.length - 1 ? tasks[_currentPage + 1] : '';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _currentPage > 0
              ? TextButton(
            onPressed: () {
              _pageController.animateToPage(_currentPage - 1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios, size: 16),
                Text(prevTask),
              ],
            ),
          )
              : SizedBox(width: 48), // Placeholder to maintain alignment
          _currentPage < tasks.length - 1
              ? TextButton(
            onPressed: () {
              _pageController.animateToPage(_currentPage + 1, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
            },
            child: Row(
              children: [
                Text(nextTask),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          )
              : SizedBox(width: 48), // Placeholder to maintain alignment
        ],
      ),
    );
  }
}
