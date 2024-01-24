import 'package:flutter/material.dart';
import 'chat_screen_manager.dart'; // ChatScreenManager import
// 다른 화면들의 import가 필요하면 여기에 추가합니다.

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // 현재 선택된 탭 인덱스

  // 각 탭에 대응하는 화면들
  final List<Widget> _screens = [
    ChatScreenManager(), // 채팅 화면
    Container(), // 우체통 화면 (구현 예정)
    Container(), // 리더보드 화면 (구현 예정)
    Container(), // 마이페이지 화면 (구현 예정)
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: '우체통',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: '리더보드',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black, // 비활성화된 아이콘 색상을 검은색으로 설정
        onTap: _onItemTapped,
      ),
    );
  }
}
