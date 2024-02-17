import 'package:flutter/material.dart';
import '../../config/palette.dart';
import './depression_diagnosis_selection_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.bgColor, // AppBar 배경색 설정
        elevation: 0, // AppBar 그림자 제거
      ),
      backgroundColor: Palette.bgColor, // Scaffold 배경색을 Palette.bgColor로 설정
      body: SingleChildScrollView( // SingleChildScrollView 추가
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset('asset/img/smileimoge.png', fit: BoxFit.contain, width: 100), // 이미지 크기 조정
              SizedBox(height: 10),
              Image.asset('asset/img/smilelettering.png', fit: BoxFit.contain, width: 100), // 이미지 크기 조정
              SizedBox(height: 20),
              _buildTextField(_emailController, '이메일을 입력하세요'),
              SizedBox(height: 10),
              _buildTextField(_passwordController, '비밀번호를 입력하세요', isPassword: true),
              SizedBox(height: 10),
              _buildTextField(_nameController, '이름을 입력하세요'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signup,
                child: Text('Sign Up', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, // 버튼 배경색 투명
                  side: BorderSide(color: Colors.white, width: 2), // 테두리 흰색
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
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

  void _signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DepressionDiagnosisSelectionScreen()),
    );
  }
}
