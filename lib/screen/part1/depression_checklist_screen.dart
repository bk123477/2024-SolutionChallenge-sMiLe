import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/result_screen.dart';

import '../../config/palette.dart';

class DepressionChecklistScreen extends StatefulWidget {
  const DepressionChecklistScreen({Key? key}) : super(key: key);

  @override
  _DepressionChecklistScreenState createState() => _DepressionChecklistScreenState();
}

class _DepressionChecklistScreenState extends State<DepressionChecklistScreen> {

  late int finalScore = 0;

  final List<String> symptoms = [
    "Little interest or pleasure in doing things ",
    "Feeling down, depressed, or hopeless.",
    "Trouble falling or staying asleep, or sleeping too much",
    "Feeling tired or having little energy",
    "Poor appetite or overeating",
    "Feeling bad about yourself - or that you are a failure or have let yourself or your family down",
    "Trouble concentrating on things, such as reading the newspaper or watching television",
    "Moving or speaking so slowly that other people could have noticed Or the opposite - being so fidgety or restless that you have been moving around a lot more than usual",
    "Thoughts that you would be better off dead, or of hurting yourself",
    "If you checked off any problems, how difficult have these problems made it for you at work, home, or with other people?",
  ];


  @override
  void initState() {
    super.initState();
  }

  Map<int, int> scores = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Back', style: TextStyle(color: Colors.black)),
        ),
        title: Center(
          child: Image.asset(
            'asset/img/smileimoge.png',
            height: 40,
          ),
        ),
        actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '${index + 1}. ${symptoms[index]}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(4, (optionIndex) => ListTile(
                        title: Text(_getOptionText(optionIndex)),
                        leading: Radio<int>(
                          value: optionIndex,
                          groupValue: scores[index],
                          onChanged: (int? value) {
                            setState(() {
                              scores[index] = value!;
                            });
                          },
                          activeColor: Palette.bgColor,
                        ),
                      )),
                    ),
                  ],
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: () async {
              finalScore = scores.values.reduce((a, b) => a + b);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('userScore', finalScore);
              print(finalScore);
              _navtoresult();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Palette.bgColor,
              textStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            child: Text('Submit and check score'),
          ),
        ],
      ),
    );
  }

  String _getOptionText(int index) {
    switch (index) {
      case 0:
        return 'Never';
      case 1:
        return 'Sometimes';
      case 2:
        return 'Usually';
      case 3:
        return 'Always';
      default:
        return '';
    }
  }

  void _navtoresult() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreenWidget()),
    );
  }
}
