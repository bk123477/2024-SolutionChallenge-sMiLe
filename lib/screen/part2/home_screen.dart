import 'package:flutter/material.dart';
import 'chat_screen_manager.dart';
import 'leaderboard_screen_manager2.dart';
import 'mailbox_screen_manager.dart';
import 'mypage_screen_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 3; // 현재 선택된 탭 인덱스

  // 각 탭에 대응하는 화면들
  final List<Widget> _screens = [
    ChatScreenManager(),
    MailboxScreenManager(),
    LeaderboardScreenManager(),
    MypageScreenManager(),
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
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/chatbubble.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/chatbubble_bold.png', width: 24, height: 24),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/mailbox.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/mailbox_bold.png', width: 24, height: 24),
            label: '우체통',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/chart.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/chart_bold.png', width: 24, height: 24),
            label: '리더보드',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/mypage.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/mypage_bold.png', width: 24, height: 24),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black, // 클릭 시 글씨 색상

        onTap: _onItemTapped,
      ),
    );
  }
}
