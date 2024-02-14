import 'package:flutter/material.dart';

class LeaderboardScreenManager extends StatefulWidget {
  @override
  _LeaderboardScreenManagerState createState() => _LeaderboardScreenManagerState();
}

class _LeaderboardScreenManagerState extends State<LeaderboardScreenManager> {
  final List<String> userNames = [
    "유저 1",
    "유저 2",
    "유저 3",
    "유저 4",
    "유저 5",
    // ... 다른 유저 이름들
  ];

  final List<String> userImageUrls = [
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
    "https://via.placeholder.com/150",
    // ... 다른 유저 프로필 사진 URL들
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('리더보드'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('필동로에는 ...', style: TextStyle(fontSize: 20)),
            SizedBox(height: 30),
            ...List.generate(5, (index) => _buildUserRow(index + 1, userNames[index], userImageUrls[index])),
          ],
        ),
      ),
    );
  }

  Widget _buildUserRow(int rank, String userName, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Text('$rank등', style: TextStyle(fontSize: 18)),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                  ),
                  SizedBox(width: 10),
                  Text(userName, style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
