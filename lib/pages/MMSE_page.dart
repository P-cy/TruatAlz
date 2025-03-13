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
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "MMSE-Thai 2002",
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FirstScreen()),
              );
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF2C3E50),
              size: 30,
            ),
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            children: [
              // หัวข้อหลัก
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: Color(0xFF3498DB),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'แบบทดสอบสภาพสมองเบื้องต้น\nMMSE-Thai 2002',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 15),

              // รายละเอียด
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // ไอคอนสมอง
                    Icon(
                      Icons.psychology,
                      size: 50,
                      color: Color(0xFF2C3E50),
                    ),
                    SizedBox(height: 15),

                    Text(
                      'แบบทดสอบนี้ใช้เพื่อประเมินความสามารถ\nของสมองเบื้องต้น \nที่มา:คณะกรรมการจัดท่าแบบทดสอบสภาพสมองเบื้องต้นฉบับภาษาไทย สถาบันเวชศาสตร์ผู้สูงอายุ กรมการแพทย์ กระทรวงสาธารณสุข ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF2C3E50),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "คำแนะนำ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withOpacity(0.5),
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Color(0xFF3498DB),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'โปรดตอบคำถามตามที่ปรากฏบนหน้าจอให้ครบทุกข้อ',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Color(0xFF3498DB),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'ใช้เวลาในการทำแบบทดสอบประมาณ 10-15 นาที',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 20,
                          color: Color(0xFF3498DB),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'กรุณาทำในสถานที่เงียบและมีสมาธิ',
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // ปุ่มเริ่มทำแบบทดสอบ
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EducationLevelScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3498DB),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 3,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'เริ่มทำแบบทดสอบ',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ข้อความด้านล่าง
              Text(
                '* ผลการทดสอบนี้ใช้สำหรับการคัดกรองเบื้องต้นเท่านั้น ไม่สามารถใช้เพื่อการวินิจฉัยทางการแพทย์',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
