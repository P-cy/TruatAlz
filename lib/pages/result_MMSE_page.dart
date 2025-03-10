// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:truat_alz/pages/chat_doctor_page.dart';
import 'package:truat_alz/pages/first_page.dart';
import 'package:truat_alz/pages/home_page.dart';

class ResultScreen extends StatelessWidget {
  final int totalScore;
  final String educationLevel;

  const ResultScreen({
    Key? key,
    required this.totalScore,
    required this.educationLevel,
  }) : super(key: key);

  String getInterpretation() {
    int cutOffPoint;
    int maxScore;

    switch (educationLevel) {
      case 'illiterate':
        cutOffPoint = 14;
        maxScore = 23;
        break;
      case 'primary':
        cutOffPoint = 17;
        maxScore = 30;
        break;
      case 'higher':
        cutOffPoint = 22;
        maxScore = 30;
        break;
      default:
        cutOffPoint = 24;
        maxScore = 30;
    }

    if (totalScore <= cutOffPoint) {
      return 'คะแนนต่ำกว่าเกณฑ์ ($cutOffPoint): มีความเสี่ยงที่จะเป็นโรคอัลไซเมอร์หรือมีความผิดปกติทางสมอง';
    } else {
      return 'คะแนนอยู่ในเกณฑ์ปกติ';
    }
  }

  @override
  Widget build(BuildContext context) {
    String interpretation = getInterpretation();
    bool isNormal = !interpretation.contains('ต่ำกว่าเกณฑ์');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF30444E),
        title: Text(
          'ผลการประเมิน',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
        child: Column(
          children: [
            const Text(
              'ผลการทดสอบ MMSE-Thai 2002',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              'คะแนนรวม: $totalScore',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: isNormal ? Colors.green.shade100 : Colors.red.shade100,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isNormal ? Colors.green : Colors.red,
                  width: 2,
                ),
              ),
              child: Text(
                interpretation,
                style: TextStyle(
                  fontSize: 18,
                  color: isNormal ? Colors.green.shade900 : Colors.red.shade900,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 40),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatDoctorScreen()),
                    );
                  },
                  icon: const Icon(
                    Icons.chat,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: const Text('ปรึกษาแพทย์',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FirstScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.exit_to_app,
                      color: Colors.white, size: 24),
                  label: const Text('ออกจากแบบทดสอบ',
                      style: TextStyle(color: Colors.white, fontSize: 24)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
