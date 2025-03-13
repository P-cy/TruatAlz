import 'package:flutter/material.dart';

class ChatDoctorScreen extends StatefulWidget {
  const ChatDoctorScreen({Key? key}) : super(key: key);

  @override
  State<ChatDoctorScreen> createState() => _ChatDoctorScreenState();
}

class _ChatDoctorScreenState extends State<ChatDoctorScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'doctor',
      'message':
          'สวัสดีครับ ผมคือ ดร. สมชาย ผมสามารถช่วยตอบคำถามเกี่ยวกับผลการทดสอบของคุณได้ครับ'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F7FA),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "ปรึกษาแพทย์",
            style: TextStyle(
              color: Color(0xFF2C3E50),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Column(children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isDoctor = message['sender'] == 'doctor';

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: isDoctor
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      if (isDoctor)
                        const CircleAvatar(
                          child: Icon(Icons.medical_services),
                        ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        decoration: BoxDecoration(
                          color: isDoctor
                              ? Colors.blue.shade100
                              : Colors.green.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(message['message']!),
                      ),
                      const SizedBox(width: 8),
                      if (!isDoctor)
                        const CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'พิมพ์ข้อความ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: Colors.blue,
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      setState(() {
                        _messages.add({
                          'sender': 'user',
                          'message': _messageController.text,
                        });

                        // Simulate doctor response
                        Future.delayed(const Duration(seconds: 1), () {
                          setState(() {
                            _messages.add({
                              'sender': 'doctor',
                              'message':
                                  'ขอบคุณสำหรับคำถาม เรากำลังพิจารณาข้อมูลเพื่อช่วยเหลือคุณให้ดีที่สุด กรุณารอสักครู่นะครับ',
                            });
                          });
                        });

                        _messageController.clear();
                      });
                    }
                  },
                ),
              ]))
        ]));
  }
}
