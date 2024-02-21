import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/home_screen.dart';

class EditMedicationScreen extends StatefulWidget{

  const EditMedicationScreen({Key? key}) : super(key: key);

  @override
  _EditMedicationScreenState createState() => _EditMedicationScreenState();
}

class _EditMedicationScreenState extends State<EditMedicationScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> _medications = [];
  @override
  void initState(){
    super.initState();
    _getUserInfo();
  }

  void _getUserInfo() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _medications = _prefs.getStringList('medications') ?? ['복용정보없음'];
    setState(() {
      _medications = _medications;
    });
  }

  void _addMedications(){
    if (_controller.text.isNotEmpty) {
      setState(() {
        _medications.add(_controller.text);
        _controller.clear();
      });
    }
  }

  void _removeMedication(int index) {
    setState(() {
      _medications.removeAt(index);
    });
  }

  void _submit() async{
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setStringList('medications', _medications);
  }


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
            'asset/img/smileimoge.png', // 실제 이미지 경로로 수정해주세요.
            height: 40,
          ),
        ),
        actions: [Opacity(opacity: 0.0, child: TextButton(onPressed: () {}, child: Text('Back')))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller, // 사용할 TextEditingController 인스턴스
              decoration: InputDecoration(
                labelText: 'Enter medication',
                labelStyle: TextStyle(fontSize: 16, color: Colors.blueGrey), // 라벨 스타일 조정
                suffixIcon: IconButton(
                  icon: Icon(Icons.add, color: Colors.black), // 아이콘 색상 추가
                  onPressed: _addMedications, // 항목 추가 함수
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // 입력칸 내부 패딩 조정
                border: OutlineInputBorder( // 텍스트 필드의 테두리 스타일
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.blueGrey),
                ),
                focusedBorder: OutlineInputBorder( // 포커스 됐을 때 테두리 스타일
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),

              onSubmitted: (value) => _addMedications(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _medications.length,
              itemBuilder: (context, index) {
                return Card( // 각 항목을 Card 위젯으로 감싸기
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(_medications[index], style: TextStyle(color: Colors.blueGrey)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeMedication(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding( // 버튼에도 padding 추가
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _submit(); // 수정 데이터 제출 함수
                _navtomypage(); // 다음 페이지로 네비게이션 함수
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black, // 버튼 텍스트 색상
                backgroundColor: Colors.white, // 버튼 배경색
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // 버튼 모서리 둥글게
                  side: BorderSide(color: Colors.black), // 테두리 색깔을 검은색으로 설정
                ),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // 버튼 내부 패딩
              ),
              child: Text('Submit Changes'),
            ),

          ),
        ],
      )

    );
  }

  void _navtomypage(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }
}