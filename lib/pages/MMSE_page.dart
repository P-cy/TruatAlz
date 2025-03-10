import 'package:flutter/material.dart';
import 'package:truat_alz/pages/chat_doctor_page.dart';
import 'package:truat_alz/pages/education_level_page.dart';
import 'package:truat_alz/pages/first_page.dart';
import 'package:truat_alz/pages/home_page.dart';

class MMSEScreen extends StatelessWidget {
  const MMSEScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF30444E),
        title: Text(
          'MMSE-Thai 2002',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FirstScreen()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          children: [
            const Text(
              'แบบทดสอบสภาพสมองเบื้องต้น \nMMSE-Thai 2002',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'แบบทดสอบนี้ใช้เพื่อประเมิน\nความสามารถของสมองเบื้องต้น',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'โปรดตอบคำถามตามที่ปรากฏบนหน้าจอให้ครบทุกข้อ',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EducationLevelScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text(
                'เริ่มทำแบบทดสอบ',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
