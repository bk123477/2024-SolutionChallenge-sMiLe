import 'package:flutter/material.dart';

class MedicationSectionWidget extends StatelessWidget {
  final List<String> medications;

  const MedicationSectionWidget({Key? key, required this.medications}) : super(key: key);

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
        ],
      ),
    );
  }
}


