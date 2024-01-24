import 'package:flutter/material.dart';
import 'package:smile_front/screen/part1/signin_screen.dart';
import 'package:smile_front/screen/part1/signup_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({Key? key}) : super(key: key);

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: _navtosignin,
                child: Text('Sign In'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _navtosignup,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navtosignin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SigninScreen()),
    );
  }

  void _navtosignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }
}
