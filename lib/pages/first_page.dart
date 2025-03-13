import 'package:flutter/material.dart';
import 'package:truat_alz/pages/calendar.dart';
import 'package:truat_alz/pages/chat_doctor_page.dart';
import 'package:truat_alz/pages/home_page.dart';
import 'package:truat_alz/pages/profile_page.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int _currentIndex = 1;
  final List<Widget> _pages = [
    const DailyQuizScreen(),
    const HomeScreen(),
    const ChatDoctorScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "หน้าหลัก", _currentIndex == 1, () {
                setState(() {
                  _currentIndex = 1;
                });
              }),
              _buildNavItem(Icons.assessment, "แบบทดสอบ", _currentIndex == 0,
                  () {
                setState(() {
                  _currentIndex = 0;
                });
              }),
              _buildNavItem(Icons.article, "บทความ", _currentIndex == 2, () {
                setState(() {
                  _currentIndex = 2;
                });
              }),
              _buildNavItem(Icons.person, "โปรไฟล์", _currentIndex == 3, () {
                setState(() {
                  _currentIndex = 3;
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? Color(0xFF3498DB) : Color(0xFF95A5A6),
            size: 24,
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Color(0xFF3498DB) : Color(0xFF95A5A6),
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
