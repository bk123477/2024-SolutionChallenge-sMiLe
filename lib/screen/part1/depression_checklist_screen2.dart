import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part1/result_screen2.dart';

class DepressionChecklistScreen extends StatefulWidget {
  const DepressionChecklistScreen({Key? key}) : super(key: key);

  @override
  _DepressionChecklistScreenState createState() => _DepressionChecklistScreenState();
}

class _DepressionChecklistScreenState extends State<DepressionChecklistScreen> {
  late int score1 = 0;
  late int score2 = 0;
  late int score3 = 0;
  late int score4 = 0;
  late int score5 = 0;
  late int score6 = 0;
  late int score7 = 0;
  late int score8 = 0;
  late int score9 = 0;
  late int score10 = 0;
  late int finalScore = 0;

  // 체크리스트 데이터 - 예시
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
    // 모든 증상에 대해 체크 상태 초기화
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('진단 체크리스트'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
           children: [
             Text('1. ${symptoms[0]}'),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Expanded(child: ListTile(
                   title: Text('전혀 아님'),
                   leading: Radio(
                     value: 0,
                     groupValue: score1,
                     onChanged: (value){
                       setState(() {
                         score1 = value!;
                       });
                     },
                   ),
                 )),
                 Expanded(child: ListTile(
                   title: Text('가끔'),
                   leading: Radio(
                     value: 1,
                     groupValue: score1,
                     onChanged: (value){
                       setState(() {
                         score1 = value!;
                       });
                     },
                   ),
                 )),
               ],
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Expanded(child: ListTile(
                   title: Text('종종'),
                   leading: Radio(
                     value: 2,
                     groupValue: score1,
                     onChanged: (value){
                       setState(() {
                         score1 = value!;
                       });
                     },
                   ),
                 )),
                 Expanded(child: ListTile(
                   title: Text('항상'),
                   leading: Radio(
                     value: 3,
                     groupValue: score1,
                     onChanged: (value){
                       setState(() {
                         score1 = value!;
                       });
                     },
                   ),
                 )),
               ]
             )
           ],
         ),
          Column(
            children: [
              Text('2. ${symptoms[1]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score2,
                      onChanged: (value){
                        setState(() {
                          score2 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score2,
                      onChanged: (value){
                        setState(() {
                          score2 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score2,
                        onChanged: (value){
                          setState(() {
                            score2 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score2,
                        onChanged: (value){
                          setState(() {
                            score2 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('3. ${symptoms[2]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score3,
                      onChanged: (value){
                        setState(() {
                          score3 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score3,
                      onChanged: (value){
                        setState(() {
                          score3 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score3,
                        onChanged: (value){
                          setState(() {
                            score3 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score3,
                        onChanged: (value){
                          setState(() {
                            score3 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('4. ${symptoms[3]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score4,
                      onChanged: (value){
                        setState(() {
                          score4 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score4,
                      onChanged: (value){
                        setState(() {
                          score4 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score4,
                        onChanged: (value){
                          setState(() {
                            score4 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score4,
                        onChanged: (value){
                          setState(() {
                            score4 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('5. ${symptoms[4]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score5,
                      onChanged: (value){
                        setState(() {
                          score5 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score5,
                      onChanged: (value){
                        setState(() {
                          score5 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score5,
                        onChanged: (value){
                          setState(() {
                            score5 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score5,
                        onChanged: (value){
                          setState(() {
                            score5 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('6. ${symptoms[5]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score6,
                      onChanged: (value){
                        setState(() {
                          score6 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score6,
                      onChanged: (value){
                        setState(() {
                          score6 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score6,
                        onChanged: (value){
                          setState(() {
                            score6 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score6,
                        onChanged: (value){
                          setState(() {
                            score6 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('7. ${symptoms[6]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score7,
                      onChanged: (value){
                        setState(() {
                          score7 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score7,
                      onChanged: (value){
                        setState(() {
                          score7 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score7,
                        onChanged: (value){
                          setState(() {
                            score7 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score7,
                        onChanged: (value){
                          setState(() {
                            score7 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('8. ${symptoms[7]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score8,
                      onChanged: (value){
                        setState(() {
                          score8 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score8,
                      onChanged: (value){
                        setState(() {
                          score8 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score8,
                        onChanged: (value){
                          setState(() {
                            score8 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score8,
                        onChanged: (value){
                          setState(() {
                            score8 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('9. ${symptoms[8]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score9,
                      onChanged: (value){
                        setState(() {
                          score9 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score9,
                      onChanged: (value){
                        setState(() {
                          score9 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score9,
                        onChanged: (value){
                          setState(() {
                            score9 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score9,
                        onChanged: (value){
                          setState(() {
                            score9 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          Column(
            children: [
              Text('10. ${symptoms[9]}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: ListTile(
                    title: Text('전혀 아님'),
                    leading: Radio(
                      value: 0,
                      groupValue: score10,
                      onChanged: (value){
                        setState(() {
                          score10 = value!;
                        });
                      },
                    ),
                  )),
                  Expanded(child: ListTile(
                    title: Text('가끔'),
                    leading: Radio(
                      value: 1,
                      groupValue: score10,
                      onChanged: (value){
                        setState(() {
                          score10 = value!;
                        });
                      },
                    ),
                  )),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: ListTile(
                      title: Text('종종'),
                      leading: Radio(
                        value: 2,
                        groupValue: score10,
                        onChanged: (value){
                          setState(() {
                            score10 = value!;
                          });
                        },
                      ),
                    )),
                    Expanded(child: ListTile(
                      title: Text('항상'),
                      leading: Radio(
                        value: 3,
                        groupValue: score10,
                        onChanged: (value){
                          setState(() {
                            score10 = value!;
                          });
                        },
                      ),
                    )),
                  ]
              )
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              finalScore = score1+score2+score3+score4+score5+score6+score7+score8+score9+score10;
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('userScore', finalScore);
              _navtoresult();
            },
            child: Text('제출하고 점수 확인하기'),
          )
        ],
      ),
    );
  }

  void _navtoresult() {
    // 체크리스트 제출 로직
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResultScreenWidget()), // 가상의 결과 스크린
    );
  }
}
