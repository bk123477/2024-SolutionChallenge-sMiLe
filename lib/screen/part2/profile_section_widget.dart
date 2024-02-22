import 'package:flutter/material.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('asset/img/smileimoge.png'),
            radius: 40,
          ),
          SizedBox(height: 8),
          Text('user@email.com'),
          SizedBox(height: 4),
          Text('유저 이름'),
          Divider(color: Colors.grey, height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('Edit Profile Tapped');
                  },
                  child: Center(
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                height: 30, // 구분선의 높이 지정
                width: 1, // 구분선의 너비
                color: Colors.grey, // 구분선의 색상
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('Logout Tapped');
                  },
                  child: Center(
                    child: Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}




