import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smile_front/screen/part2/edit_medication_screen.dart'; // 경로는 실제 프로젝트에 맞게 조정해주세요.

class MedicationSectionWidget extends StatefulWidget {
  late List<String> medications;

  MedicationSectionWidget({Key? key, required this.medications}) : super(key: key);

  @override
  _MedicationSectionWidgetState createState() => _MedicationSectionWidgetState();
}

class _MedicationSectionWidgetState extends State<MedicationSectionWidget> {
  late List<String> medications = [];

  @override
  void initState() {
    super.initState();
    getMedications();
  }

  getMedications() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    medications = _prefs.getStringList('medications') ?? ['No dosage information'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...medications.map((medication) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(medication, textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
          )).toList(),
          SizedBox(height: 20),
          Divider(color: Colors.grey, height: 20),
          InkWell(
            onTap: _navtoedit, // onTap 메소드에 _navtoedit 함수 연결
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Row 내용에 맞게 크기 조정
                children: [
                  Icon(Icons.edit, color: Colors.black), // 연필 아이콘 유지
                  SizedBox(width: 8), // 아이콘과 텍스트 사이 간격
                  Text('edit medications', style: TextStyle(fontSize: 16, color: Colors.black)), // 텍스트 스타일 조정
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }

  void _navtoedit() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditMedicationScreen()));
  }
}
