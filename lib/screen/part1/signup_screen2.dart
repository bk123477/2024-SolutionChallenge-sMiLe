import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/home_screen.dart';
import '/firebase_options.dart';
import 'package:intl/intl.dart';

import './depression_diagnosis_selection_screen.dart';

showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  late String email;
  late String password;
  late String name;
  late int flag = 0;
  late int userScore;
  late List<String> medications;
  late bool _complete1 = false;
  late bool _complete2 = false;
  late bool _complete3 = false;
  late bool _complete4 = false;
  late bool _complete5 = false;
  late bool _complete6 = false;

  late String _dt1 = "";
  late String _dt2 = "";
  late String _dt3 = "";
  late String _dt4 = "";
  late String _dt5 = "";
  late String _dt6 = "";
  late int _mission1 = 0;
  late int _mission2 = 0;
  late int _mission3 = 0;
  late int _mission4 = 0;
  late int _mission5 = 0;
  late int _mission6 = 0;
  bool isInput = true; //false - result
  bool isSignIn = true; //false - SingUp

  getUser() async {
    final DateTime now = DateTime.now();
    final String nowStr = DateFormat('yy-MM-dd').format(now);
    DocumentSnapshot _userDoc = await FirebaseFirestore.instance.collection('users').doc(email).get();
    if (_userDoc.exists) {
      Map<String, dynamic> userData = _userDoc.data() as Map<String, dynamic>;
      email = userData['userInfo'];
      name = userData['userName'];
      userScore = userData['userScore'];
      medications = List<String>.from(userData['medications']);
      _complete1 = userData['complete1'] ?? false;
      _complete2 = userData['complete2'] ?? false;
      _complete3 = userData['complete3'] ?? false;
      _complete4 = userData['complete4'] ?? false;
      _complete5 = userData['complete5'] ?? false;
      _complete6 = userData['complete6'] ?? false;
      _dt1 = userData['dt1'] ?? "";
      _dt2 = userData['dt2'] ?? "";
      _dt3 = userData['dt3'] ?? "";
      _dt4 = userData['dt4'] ?? "";
      _dt5 = userData['dt5'] ?? "";
      _dt6 = userData['dt6'] ?? "";
      _mission1 = userData['mission1'] ?? 0;
      _mission2 = userData['mission2'] ?? 0;
      _mission3 = userData['mission3'] ?? 0;
      _mission4 = userData['mission4'] ?? 0;
      _mission5 = userData['mission5'] ?? 0;
      _mission6 = userData['mission6'] ?? 0;

      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('userInfo', email);
      _prefs.setString('userName', name);
      _prefs.setInt('userScore', userScore);
      _prefs.setStringList('medications', medications);
      if (nowStr == _dt1){
        _prefs.setBool('complete1', _complete1);
      } else {
        _prefs.setBool('complete1', false);
      }
      if (nowStr == _dt2){
        _prefs.setBool('complete2', _complete2);
      } else {
        _prefs.setBool('complete2', false);
      }
      if (nowStr == _dt3){
        _prefs.setBool('complete3', _complete3);
      } else {
        _prefs.setBool('complete3', false);
      }
      if (nowStr == _dt4){
        _prefs.setBool('complete4', _complete4);
      } else {
        _prefs.setBool('complete4', false);
      }
      if (nowStr == _dt5){
        _prefs.setBool('complete5', _complete5);
      } else {
        _prefs.setBool('complete5', false);
      }
      if (nowStr == _dt6){
        _prefs.setBool('complete6', _complete6);
      } else {
        _prefs.setBool('complete6', false);
      }
      _prefs.setString('dt1', _dt1);
      _prefs.setString('dt2', _dt2);
      _prefs.setString('dt3', _dt3);
      _prefs.setString('dt4', _dt4);
      _prefs.setString('dt5', _dt5);
      _prefs.setString('dt6', _dt6);
      _prefs.setInt('mission1', _mission1);
      _prefs.setInt('mission2', _mission2);
      _prefs.setInt('mission3', _mission3);
      _prefs.setInt('mission4', _mission4);
      _prefs.setInt('mission5', _mission5);
      _prefs.setInt('mission6', _mission6);

      flag = 1;
    } else {
      flag = 0;
    }
  }

  signIn() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        print(value); // value에 사용자 이메일 들어가 있음.

        if (value.user!.emailVerified) {
          //이메일 인증 여부
          setState(() {
            isInput = false;
          });
        } else {
          showToast('emailVerified error');
        }
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast('user-not-found');
      } else if (e.code == 'wrong-password') {
        showToast('wrong-password');
      } else {
        print(e.code);
      }
    }
  }

  signOut() async {
    await FirebaseAuth.instance.signOut();
    setState(() {
      isInput = true;
    });
  }

  signUp() async{
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        if (value.user!.email != null) {
          FirebaseAuth.instance.currentUser?.sendEmailVerification();
          setState(() {
            isInput = false;
          });
        }
        return value;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast('weak-password');
      } else if (e.code == 'email-already-in-use') {
        showToast('email-already-in-use');
      } else {
        showToast('other error');
        print(e.code);
      }
    } catch (e) {
      print(e.toString());
    }
  }
  
  List<Widget> getInputWidget() {
    return[
      Text(
        isSignIn ? "SignIn" : "SignUp",
        style: TextStyle(
          color: Colors.indigo,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
      Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TextFormField(
              decoration: InputDecoration(
                labelText: '이메일을 입력하세요',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'Please enter email';
                }
                return null;
              },
              onSaved: (String? value) {
                email = value ?? "";
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                labelText: '비밀번호를 입력하세요',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              validator: (value) {
                if (value?.isEmpty ?? false) {
                  return 'Please enter password';
                }
                return null;
              },
              onSaved: (String? value) {
                password = value ?? "";
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: (){
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();
                // print('email: $email, password : $password');
                if (isSignIn) {
                  signIn();
                  getUser();
                  print(flag);
                } else {
                  signUp();
                }
              }
            }, child: Text(isSignIn ? "SignIn" : "SignUp")),
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                text: 'Go ',
                style: Theme.of(context).textTheme.bodyText1,
                children: <TextSpan>[
                  TextSpan(
                      text: isSignIn ? "SignUp" : "SignIn",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          setState(() {
                            isSignIn = !isSignIn;
                          });
                        }),
                ],
              ),
            ),
          ]
        )
      )
    ];
  }

  List<Widget> getResultWidget() {
    String resultEmail = FirebaseAuth.instance.currentUser!.email!;
    return [
      Text(
        isSignIn
            ? "$resultEmail 로 로그인 하셨습니다.!"
            : "$resultEmail 로 회원가입 하셨습니다.! 이메일 인증을 거쳐야 로그인이 가능합니다.",
        style: TextStyle(
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        ),
      ),
      ElevatedButton(
          onPressed: () async {
            if (isSignIn && flag == 0) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              prefs.setString('userInfo', resultEmail);
              prefs.setString('userName', resultEmail.split('@')[0]);
              print(prefs.get('userInfo'));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DepressionDiagnosisSelectionScreen()),
              );
            } else if (isSignIn && flag == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            }
            else {
              setState(() {
                isInput = true;
                isSignIn = true;
              });
            }
          },
          child: Text(isSignIn ? "시작하기" : "SignIn")),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("sMiLe"),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: isInput ? getInputWidget() : getResultWidget()),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Sign Up'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           TextFormField(
  //             controller: _emailController,
  //             decoration: InputDecoration(
  //               labelText: '이메일을 입력하세요',
  //               border: OutlineInputBorder(),
  //             ),
  //             keyboardType: TextInputType.emailAddress,
  //             validator: (value) {
  //               if (value?.isEmpty ?? false) {
  //                 return 'Please enter email';
  //               }
  //               return null;
  //             },
  //             onSaved: (String? value) {
  //               email = value ?? "";
  //             },
  //           ),
  //           SizedBox(height: 10),
  //           TextFormField(
  //             controller: _passwordController,
  //             decoration: InputDecoration(
  //               labelText: '비밀번호를 입력하세요',
  //               border: OutlineInputBorder(),
  //             ),
  //             obscureText: true,
  //             validator: (value) {
  //               if (value?.isEmpty ?? false) {
  //                 return 'Please enter password';
  //               }
  //               return null;
  //             },
  //             onSaved: (String? value) {
  //               password = value ?? "";
  //             },
  //           ),
  //           SizedBox(height: 10),
  //           TextFormField(
  //             controller: _nameController,
  //             decoration: InputDecoration(
  //               labelText: '이름을 입력하세요',
  //               border: OutlineInputBorder(),
  //             ),
  //             validator: (value) {
  //               if (value?.isEmpty ?? false) {
  //                 return 'Please enter name';
  //               }
  //               return null;
  //             },
  //             onSaved: (String? value) {
  //               name = value ?? "";
  //             },
  //           ),
  //           SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: _signup,
  //             child: Text('Sign Up'),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

//TODO: 지금은 로그인화면으로 가거나 자동으로 로그인 시켜주지 않고 바로 진단화면으로 간다. 이것은 나중에 로직을 다시 짜야함.
  void _signup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DepressionDiagnosisSelectionScreen()),
    );
  }

}
