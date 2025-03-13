// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:truat_alz/pages/chat_doctor_page.dart';
import 'package:truat_alz/pages/first_page.dart';
import 'package:truat_alz/pages/home_page.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

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

    // ข้อมูลเกณฑ์คะแนนตามระดับการศึกษา
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

    // คำนวณเปอร์เซ็นต์คะแนน
    double scorePercent = totalScore / maxScore;
    if (scorePercent > 1.0) scorePercent = 1.0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF30444E),
        title: const Text(
          'ผลการประเมิน',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF30444E),
              const Color(0xFF30444E).withOpacity(0.8),
              Colors.white,
            ],
            stops: const [0.0, 0.2, 0.3],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const Text(
                          'ผลการทดสอบ MMSE-Thai 2002',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF30444E),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        CircularPercentIndicator(
                          radius: 100.0,
                          lineWidth: 15.0,
                          animation: true,
                          percent: scorePercent,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$totalScore',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40.0,
                                  color: isNormal
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                ),
                              ),
                              Text(
                                '/ $maxScore',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          footer: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              'คะแนนรวม',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: isNormal
                                    ? Colors.green.shade700
                                    : Colors.red.shade700,
                              ),
                            ),
                          ),
                          circularStrokeCap: CircularStrokeCap.round,
                          progressColor: isNormal
                              ? Colors.green.shade500
                              : Colors.red.shade500,
                          backgroundColor: Colors.grey.shade200,
                        ),
                        const SizedBox(height: 30),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: isNormal
                                ? Colors.green.shade50
                                : Colors.red.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: isNormal
                                  ? Colors.green.shade300
                                  : Colors.red.shade300,
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isNormal
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.red.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Icon(
                                isNormal
                                    ? Icons.check_circle
                                    : Icons.warning_amber_rounded,
                                color: isNormal ? Colors.green : Colors.red,
                                size: 40,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                interpretation,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: isNormal
                                      ? Colors.green.shade900
                                      : Colors.red.shade900,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                // const Text(
                //   'ขั้นตอนต่อไป',
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //     color: Color(0xFF30444E),
                //   ),
                // ),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // ElevatedButton.icon(
                        //   onPressed: () {
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const ChatDoctorScreen()),
                        //     );
                        //   },
                        //   icon: const Icon(
                        //     Icons.chat_bubble_outline,
                        //     color: Colors.white,
                        //     size: 24,
                        //   ),
                        //   label: const Text('ปรึกษาแพทย์',
                        //       style:
                        //           TextStyle(color: Colors.white, fontSize: 20)),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.blue,
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 24, vertical: 16),
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(30),
                        //     ),
                        //     elevation: 5,
                        //     minimumSize: const Size(double.infinity, 60),
                        //   ),
                        // ),
                        // const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const FirstScreen()),
                              (route) => false,
                            );
                          },
                          icon: const Icon(Icons.home_outlined,
                              color: Colors.white, size: 24),
                          label: const Text('กลับหน้าหลัก',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF30444E),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 24, vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                            minimumSize: const Size(double.infinity, 60),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // TextButton.icon(
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return AlertDialog(
                //           title: const Text('ยืนยันการออกจากแบบทดสอบ'),
                //           content:
                //               const Text('คุณต้องการออกจากแบบทดสอบใช่หรือไม่?'),
                //           actions: [
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.of(context).pop();
                //               },
                //               child: const Text('ยกเลิก'),
                //             ),
                //             TextButton(
                //               onPressed: () {
                //                 Navigator.pushAndRemoveUntil(
                //                   context,
                //                   MaterialPageRoute(
                //                       builder: (context) =>
                //                           const FirstScreen()),
                //                   (route) => false,
                //                 );
                //               },
                //               child: const Text('ออกจากแบบทดสอบ',
                //                   style: TextStyle(color: Colors.red)),
                //             ),
                //           ],
                //         );
                //       },
                //     );
                //   },
                //   icon: const Icon(Icons.exit_to_app,
                //       color: Colors.red, size: 20),
                //   label: const Text('ออกจากแบบทดสอบ',
                //       style: TextStyle(color: Colors.red)),
                //   style: TextButton.styleFrom(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
