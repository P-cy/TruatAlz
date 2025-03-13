import 'package:flutter/material.dart';
import 'package:truat_alz/pages/MMSE_page.dart';
import 'dart:async';

import 'package:truat_alz/pages/alz_content_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<Map<String, dynamic>> _slideImages = [
    {
      'image': 'assets/img/slide1.jpg',
      'title': 'ผู้สูงอายุ เสี่ยงภาวะสมองเสื่อม',
      'description': 'ตรวจสอบอาการเบื้องต้นได้ด้วยตัวเอง'
    },
    {
      'image': 'assets/img/slide2.jpg',
      'title': 'ประเมินความเสี่ยง',
      'description': 'แบบทดสอบมาตรฐานทางการแพทย์'
    },
  ];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < _slideImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.psychology,
              color: Color(0xFF3498DB),
              size: 28,
            ),
            SizedBox(width: 8),
            Text(
              "TruAt Alzheimer",
              style: TextStyle(
                color: Color(0xFF2C3E50),
                fontWeight: FontWeight.bold,
                fontSize: 22,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: Color(0xFF2C3E50),
                  size: 24,
                ),
                tooltip: 'การตั้งค่า',
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 15),
            // ส่วนของสไลด์โชว์
            Container(
              height: 250,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      itemCount: _slideImages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  // รูปภาพ
                                  Positioned.fill(
                                    child: Hero(
                                      tag:
                                          'slide-${_slideImages[index]['image']}',
                                      child: Image.asset(
                                        _slideImages[index]['image'],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  // เกรเดียนต์สีดำโปร่งแสง
                                  Positioned.fill(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black.withOpacity(0.75),
                                          ],
                                          stops: [0.6, 1.0],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // ข้อความบนสไลด์
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    right: 20,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _slideImages[index]['title'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 3.0,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          _slideImages[index]['description'],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 3.0,
                                                color: Colors.black
                                                    .withOpacity(0.3),
                                                offset: Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 15),
                  // ตัวบอกตำแหน่งสไลด์
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slideImages.length,
                      (index) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _currentPage == index ? 20 : 10,
                        height: 10,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: _currentPage == index
                              ? Color(0xFF3498DB)
                              : Color(0xFFD8D8D8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          width: 5,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Color(0xFF3498DB),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "บริการของเรา",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // ปุ่มแบบทดสอบ
                  _buildServiceCard(
                    context,
                    title: 'แบบทดสอบ',
                    imagePath: 'assets/img/to-do-list.png',
                    color: Color(0xFF3498DB),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MMSEScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  // ปุ่มโรคอัลไซเมอร์
                  _buildServiceCard(
                    context,
                    title: 'โรคอัลไซเมอร์',
                    imagePath: 'assets/img/brain.png',
                    color: Color(0xFF2ECC71),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AlzheimersContentScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 20),
                  // เพิ่มบริการใหม่: คำแนะนำดูแลผู้ป่วย
                  _buildServiceCard(
                    context,
                    title: 'คำแนะนำการดูแล',
                    imagePath: 'assets/img/health-care.png',
                    color: Color(0xFFE74C3C),
                    onTap: () {
                      // TODO: เพิ่ม navigator ไปยังหน้าคำแนะนำ
                    },
                  ),
                  SizedBox(height: 30),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ทำไมต้องประเมิน?",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2C3E50),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "การตรวจคัดกรองเบื้องต้นสามารถช่วยให้พบอาการของโรคอัลไซเมอร์ได้เร็วขึ้น ทำให้การรักษามีประสิทธิภาพมากขึ้น",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF7F8C8D),
                            height: 1.5,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // TODO: นำทางไปยังหน้าข้อมูลเพิ่มเติม
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF3498DB),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: Text(
                                  "ข้อมูลเพิ่มเติม",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String imagePath,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        imagePath,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: color,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
