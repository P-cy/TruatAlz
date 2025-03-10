import 'package:flutter/material.dart';
import 'package:truat_alz/pages/calendar.dart';
import 'package:truat_alz/pages/home_page.dart';

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
    const Center(child: Text("Chat Page")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF3ED598),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(40)),
          ),
          onPressed: () {
            setState(() {
              _currentIndex = 1;
            });
          },
          child: const Icon(
            Icons.home_filled,
            size: 45,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFF2C3E50),
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 0;
                });
              },
              icon: const Icon(Icons.calendar_month_rounded),
              color: _currentIndex == 0 ? const Color(0xFF3ED598) : Colors.grey,
              iconSize: 30,
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                setState(() {
                  _currentIndex = 2;
                });
              },
              icon: const Icon(Icons.chat_rounded),
              color: _currentIndex == 2 ? const Color(0xFF3ED598) : Colors.grey,
              iconSize: 30,
            ),
          ],
        ),
      ),
    );
  }
}
