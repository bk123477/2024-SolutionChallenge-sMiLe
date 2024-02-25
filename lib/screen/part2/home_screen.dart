import 'package:flutter/material.dart';
import 'chat_screen_manager.dart';
import 'leaderboard_screen_manager.dart';
import 'mailbox_screen_manager.dart';
import 'mypage_screen_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 3;

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
            label: 'Chatting',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/mailbox.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/mailbox_bold.png', width: 24, height: 24),
            label: 'Mailbox',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/chart.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/chart_bold.png', width: 24, height: 24),
            label: 'Leaderboards',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('asset/img/bottom_bar/mypage.png', width: 24, height: 24),
            activeIcon: Image.asset('asset/img/bottom_bar/mypage_bold.png', width: 24, height: 24),
            label: 'Mypage',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,

        onTap: _onItemTapped,
      ),
    );
  }
}
