import 'package:flutter/material.dart';
import '../../config/palette.dart';
import '../part2/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultScreenWidget extends StatefulWidget{
  const ResultScreenWidget({Key? key}) : super(key: key);

  @override
  _ResultScreenWidgetState createState() => _ResultScreenWidgetState();
}

class _ResultScreenWidgetState extends State<ResultScreenWidget> {
  int _userScore = 0;
  String _userInfo = '';

  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  _getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userInfo = prefs.getString('email')?.split('@')[0] ?? 'User';
    });
    setState(() {
      _userScore = prefs.getInt('userScore')!;
    });
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
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_userInfo\'s Diagnosis Result',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Palette.bgColor,
                ),
              ),
              SizedBox(height: 20),
              Text(

                _userScore < 5 ? 'Minimal Depression ($_userScore)' :
                _userScore < 10 ? 'Mild Depression ($_userScore)' :
                _userScore < 15 ? 'Moderate Depression ($_userScore)' :
                _userScore < 20 ? 'Moderately Severe Depression ($_userScore)' :
                'Severe Depression ($_userScore)',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Palette.bgColor,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Confirm'),
              ),
            ],
          ),
        ),
      ),

    );
  }
}