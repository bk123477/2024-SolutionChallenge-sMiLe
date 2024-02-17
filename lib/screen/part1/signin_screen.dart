import 'package:flutter/material.dart';
import '../../config/palette.dart';
import 'package:smile_front/screen/part2/home_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.bgColor, // 배경색 설정
      body: SingleChildScrollView( // SingleChildScrollView 추가
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 이미지 상단에 바짝 붙도록 Padding 조정
              Padding(
                padding: const EdgeInsets.only(top: 40.0), // 상단 여백 추가
                child: Image.asset('asset/img/smileimoge.png', fit: BoxFit.contain, width: 100),
              ),
              SizedBox(height: 20), // 이미지 간 간격 조정
              Image.asset('asset/img/smilelettering.png', fit: BoxFit.contain, width: 100),
              SizedBox(height: 40), // 이미지와 입력 필드 사이 간격 조정
              _buildTextField(_emailController, '이메일을 입력하세요'),
              SizedBox(height: 10),
              _buildTextField(_passwordController, '비밀번호를 입력하세요', isPassword: true),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signin,
                child: Text('Sign In', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  side: BorderSide(color: Colors.white, width: 2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 20),
              // Google 로그인 버튼 디자인 유지
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black87,
                  backgroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  ),
                ),
                onPressed: () {
                  // Google 로그인 로직 구현
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Image.asset('asset/img/glogo.png', width: 24, height: 24),
                    Text('Login with Google', style: TextStyle(fontSize: 15.0)),
                    Opacity(opacity: 0.0, child: Image.asset('asset/img/glogo.png', width: 24, height: 24)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.transparent,
        filled: true,
      ),
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      keyboardType: isPassword ? TextInputType.text : TextInputType.emailAddress,
    );
  }

  void _signin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
