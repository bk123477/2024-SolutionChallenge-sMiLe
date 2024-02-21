import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/edit_medication_screen.dart';

class MedicationSectionWidget extends StatefulWidget {
  late List<String> medications;

  MedicationSectionWidget({Key? key,
  required this.medications}) : super(key: key);

  @override
  _MedicationSectionWidgetState createState() => _MedicationSectionWidgetState();

}

class _MedicationSectionWidgetState extends State<MedicationSectionWidget> {
  late List<String> medications = [];

  @override
  void initState(){
    super.initState();
    getMedications();
  }

  getMedications() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    medications = _prefs.getStringList('medications')!;
    print(medications);
    setState(() {
      if (medications.length == 0){
        medications = ['복용정보없음'];
      } else {
        medications = medications;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // 컨테이너 너비 확장
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 가로축 중앙 정렬
        children: [
          Text('약 복용 정보', style: TextStyle(fontSize: 20)),
          ...medications.map((medication) => Text(medication, textAlign: TextAlign.center)).toList(),
          ElevatedButton(
            onPressed: (){
              _navtoedit();
            },
            child: Text('수정하기'),
          )
        ],
      ),
    );
  }

  void _navtoedit(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditMedicationScreen()));
  }
}


