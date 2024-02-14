import 'package:flutter/material.dart';

import 'package:smile_front/screen/part1/loading_screen.dart';



void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  final bool isLoggedIn = false;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'smile_front',
        home: LoadingScreen(),
      ),
    );
  }
}


//TODO: 포커스 - 텍스트 입력하고 빈화면 터치시 키패드 unfocus하는 기능