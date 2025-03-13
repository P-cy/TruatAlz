import 'package:flutter/material.dart';
import 'package:truat_alz/pages/MMSE_page.dart';
import 'package:truat_alz/pages/result_MMSE_page.dart';

class TestMMSEScreen extends StatefulWidget {
  final String educationLevel;

  const TestMMSEScreen({super.key, required this.educationLevel});

  @override
  State<TestMMSEScreen> createState() => _TestMMSEScreenState();
}

class _TestMMSEScreenState extends State<TestMMSEScreen> {
  int currentQuestionIndex = 0;
  int totalScore = 0;
  List<int> sectionScores = List.filled(11, 0); // Store scores for each section
  TextEditingController textAnswerController = TextEditingController();
  bool showTextInputField = false;
  int _currentSection = 1; // Track the current section
  List<bool> _answeredQuestions = []; // Track answered questions

  // คอนสแตนต์สำหรับสี
  final Color primaryColor = const Color(0xFF30444E);
  final Color secondaryColor = const Color(0xFF4A6572);
  final Color accentColor = const Color(0xFF63ADF2);
  final Color correctColor = const Color(0xFF4CAF50);
  final Color incorrectColor = const Color(0xFFF44336);
  final Color neutralColor = const Color(0xFF2196F3);
  final Color backgroundColor = const Color(0xFFF5F5F5);

  // แก้ไขภาพประกอบสำหรับแต่ละส่วน
  final Map<int, IconData> sectionIcons = {
    1: Icons.access_time,
    2: Icons.location_on,
    3: Icons.memory,
    4: Icons.calculate,
    5: Icons.psychology,
    6: Icons.visibility,
    7: Icons.record_voice_over,
    8: Icons.touch_app,
    9: Icons.menu_book,
    10: Icons.edit,
    11: Icons.gesture,
  };

  final List<Map<String, dynamic>> questions = [
    // Section 1: Orientation for time
    {
      'section': 1,
      'title': 'การรับรู้เกี่ยวกับเวลาในปัจจุบัน',
      'questions': [
        {'question': '1.1 วันนี้วันที่เท่าไร', 'maxScore': 1},
        {'question': '1.2 วันนี้วันอะไร', 'maxScore': 1},
        {'question': '1.3 เดือนนี้เดือนอะไร', 'maxScore': 1},
        {'question': '1.4 ปีนี้ปีอะไร', 'maxScore': 1},
        {'question': '1.5 ฤดูนี้ฤดูอะไร', 'maxScore': 1},
      ],
      'instructions': 'ตอบถูกต้องได้ 1 คะแนน ตอบผิดได้ 0 คะแนน',
    },
    // Section 2: Orientation for place
    {
      'section': 2,
      'title': 'การรับรู้เกี่ยวกับที่อยู่ในปัจจุบัน',
      'questions': [
        {
          'question': '2.1.1 สถานที่ตรงนี้เรียกว่าอะไร ชื่อว่าอะไร',
          'maxScore': 1
        },
        {'question': '2.1.2 ขณะนี้อยู่ชั้นที่เท่าไรของตัวอาคาร', 'maxScore': 1},
        {'question': '2.1.3 ที่นี่อยู่ในอำเภออะไร', 'maxScore': 1},
        {'question': '2.1.4 ที่นี่จังหวัดอะไร', 'maxScore': 1},
        {'question': '2.1.5 ที่นี่ภาคอะไร', 'maxScore': 1},
      ],
      'instructions':
          'กรณีอยู่โรงพยาบาล: ตอบถูกต้องได้ 1 คะแนน ตอบผิดได้ 0 คะแนน\n\nกรณีอยู่ที่บ้าน: ให้ถามข้อ 2.2.1-2.2.5 แทน',
    },
    // Section 3: Registration
    {
      'section': 3,
      'title': 'การบันทึกความจำ',
      'question':
          'ต่อไปนี้จะเป็นการทดสอบความจำโดยจะบอกชื่อของ 3 อย่าง ให้คุณ (ตา,ยาย...) ฟังดีๆ นะคะ จะบอกเพียงครั้งเดียว เมื่อพูดจบแล้วให้คุณ (ตา,ยาย...) พูดทวนตามที่ได้ยินทั้ง 3 ชื่อแล้วจำไว้ให้ดีนะคะ เดี๋ยวจะถามซ้ำ\n\nดอกไม้ แม่น้ำ รถไฟ',
      'instructions':
          'จำได้ทั้ง 3 คำได้ 3 คะแนน, จำได้ 2 คำได้ 2 คะแนน, จำได้ 1 คำได้ 1 คะแนน, จำไม่ได้เลยได้ 0 คะแนน',
      'maxScore': 3,
      'needInput': true,
    },
    // Section 4: Attention or Calculation
    {
      'section': 4,
      'title': 'ทดสอบสมาธิโดยให้คิดเลขในใจ',
      'question':
          'ถามผู้ถูกทดสอบว่า "คิดเลขในใจเป็นหรือไม่" ถ้าคิดเป็นให้ทำข้อ 4.1 ถ้าคิดไม่เป็นหรือไม่ตอบให้ทำข้อ 4.2\n\n4.1 ข้อนี้คิดเลขในใจโดยเอา 100 ตั้ง ลบออกทีละ 7 ไปเรื่อยๆ ได้ผลลัพธ์เท่าไรบอกมา (93, 86, 79, 72, 65)\n\n4.2 "เดี๋ยวผม(ดิฉัน)จะสะกดคำว่ามะนาวให้คุณ(ตา,ยาย)ฟัง แล้วให้คุณ(ตา,ยาย)สะกดถอยหลังจากพยัญชนะตัวหลังไปตัวแรก คำว่ามะนาวสะกดว่า มอม้า—สระอะ—นอหนู—สระอา—วอแหวน คุณ(ตา,ยาย)สะกดถอยหลังให้ฟังสิครับ(คะ)"',
      'instructions':
          'ข้อ 4.1: ตอบถูกแต่ละครั้งได้ 1 คะแนน รวม 5 คะแนน\nข้อ 4.2: สะกดถอยหลังถูกแต่ละตัวได้ 1 คะแนน รวม 5 คะแนน\n\nหมายเหตุ: ผู้สูงอายุที่ไม่ได้เรียนหรือไม่รู้หนังสือไม่ต้องทำข้อนี้',
      'maxScore': 5,
      'needInput': true,
    },
    // Section 5: Recall
    {
      'section': 5,
      'title': 'ทดสอบความจำระยะสั้น',
      'question':
          'เมื่อสักครู่ที่ให้จำของ 3 อย่าง จำได้ไหม มีอะไรบ้าง\n\nดอกไม้ แม่น้ำ รถไฟ',
      'instructions':
          'จำได้ทั้ง 3 คำได้ 3 คะแนน, จำได้ 2 คำได้ 2 คะแนน, จำได้ 1 คำได้ 1 คะแนน, จำไม่ได้เลยได้ 0 คะแนน',
      'maxScore': 3,
      'needInput': true,
    },
    // Section 6: Naming
    {
      'section': 6,
      'title': 'การบอกชื่อสิ่งของที่ได้เห็น',
      'questions': [
        {
          'question':
              '6.1 ยื่นดินสอให้ผู้ถูกทดสอบดูแล้วถามว่า "ของสิ่งนี้เรียกว่าอะไร"',
          'maxScore': 1
        },
        {
          'question':
              '6.2 ชี้นาฬิกาข้อมือให้ผู้ถูกทดสอบดูแล้วถามว่า "ของสิ่งนี้เรียกว่าอะไร"',
          'maxScore': 1
        },
      ],
      'instructions': 'ตอบถูกต้องได้ 1 คะแนน ตอบผิดได้ 0 คะแนน',
    },
    // Section 7: Repetition
    {
      'section': 7,
      'title': 'การพูดซ้ำคำที่ได้ยิน',
      'question':
          'ตั้งใจฟังผม(ดิฉัน)นะ เมื่อผม(ดิฉัน)พูดข้อความนี้แล้วให้คุณ(ตา,ยาย)พูดตามผม(ดิฉัน) จะบอกเพียงเที่ยวเดียว "ใครใคร่ขายไก่ไข่"',
      'instructions': 'พูดซ้ำได้ถูกต้องได้ 1 คะแนน พูดผิดได้ 0 คะแนน',
      'maxScore': 1,
      'needInput': true,
    },
    // Section 8: Verbal command
    {
      'section': 8,
      'title': 'การเข้าใจความหมายและทำตามคำสั่ง',
      'question':
          'ข้อนี้ให้ทำตามที่บอก ตั้งใจฟังดีๆ นะ เดี๋ยวผม(ดิฉัน)จะส่งกระดาษให้ แล้วให้คุณ(ตา,ยาย)รับด้วยมือขวา พับครึ่งด้วยมือทั้ง 2 ข้าง เสร็จแล้ววางไว้ที่(พื้น,โต๊ะ,เตียง)',
      'instructions': 'ทำถูกต้องแต่ละขั้นตอนได้ 1 คะแนน รวม 3 คะแนน',
      'maxScore': 3,
      'needInput': true,
    },
    // Section 9: Written command
    {
      'section': 9,
      'title': 'การอ่านและเข้าใจความหมาย',
      'question':
          'ให้คุณ(ตา,ยาย...)อ่านแล้วทำตาม จะอ่านออกเสียงหรืออ่านในใจก็ได้\n(แสดงกระดาษที่เขียนว่า "หลับตา")',
      'instructions':
          'อ่านและทำตามได้ถูกต้องได้ 1 คะแนน\n\nหมายเหตุ: ผู้สูงอายุที่ไม่ได้เรียนหรือไม่รู้หนังสือไม่ต้องทำข้อนี้',
      'maxScore': 1,
      'needInput': true,
    },
    // Section 10: Writing
    {
      'section': 10,
      'title': 'การเขียนภาษาอย่างมีความหมาย',
      'question':
          'ให้คุณ(ตา,ยาย)เขียนข้อความอะไรก็ได้ที่อ่านแล้วรู้เรื่องหรือมีความหมาย 1 ประโยค',
      'instructions':
          'เขียนประโยคที่มีความหมายได้ 1 คะแนน\n\nหมายเหตุ: ผู้สูงอายุที่ไม่ได้เรียนหรือไม่รู้หนังสือไม่ต้องทำข้อนี้',
      'maxScore': 1,
      'needInput': true,
    },
    // Section 11: Visuoconstruction
    {
      'section': 11,
      'title': 'ความสัมพันธ์ระหว่างตากับมือ',
      'question':
          'ให้คุณ(ตา,ยาย)วาดภาพให้เหมือนภาพตัวอย่าง (รูปห้าเหลี่ยมซ้อนกัน)',
      'instructions': 'วาดได้ถูกต้องได้ 1 คะแนน',
      'maxScore': 1,
      'needInput': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnsweredQuestions();
    _skipQuestionsBasedOnEducation();
  }

  void _initializeAnsweredQuestions() {
    if (questions.isNotEmpty && currentQuestionIndex < questions.length) {
      _answeredQuestions = List.filled(
          questions[currentQuestionIndex]['questions']?.length ?? 1, false);
    }
  }

  void _skipQuestionsBasedOnEducation() {
    // Skip questions 4, 9, and 10 for those who cannot read or write
    if (widget.educationLevel == 'ไม่ได้เรียนหนังสือ') {
      setState(() {
        // Mark these sections to be skipped
        questions[3]['skip'] = true; // Section 4 (index 3)
        questions[8]['skip'] = true; // Section 9 (index 8)
        questions[9]['skip'] = true; // Section 10 (index 9)
      });
    }
  }

  void nextQuestion(int score) {
    int currentSection = questions[currentQuestionIndex]['section'].toInt();

    // Update section score
    sectionScores[currentSection - 1] += score;

    // Update total score
    totalScore += score;

    setState(() {
      currentQuestionIndex++;

      // Skip questions if needed based on education level
      while (currentQuestionIndex < questions.length &&
          questions[currentQuestionIndex]['skip'] == true) {
        currentQuestionIndex++;
      }

      if (currentQuestionIndex < questions.length) {
        _currentSection = questions[currentQuestionIndex]['section'];
      }

      // Check if test is complete
      if (currentQuestionIndex >= questions.length) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              totalScore: totalScore,
              educationLevel: widget.educationLevel,
            ),
          ),
        );
      }

      // Reset text field for next question
      textAnswerController.clear();
      showTextInputField = questions[currentQuestionIndex < questions.length
                  ? currentQuestionIndex
                  : 0]
              .containsKey('needInput') &&
          questions[currentQuestionIndex < questions.length
              ? currentQuestionIndex
              : 0]['needInput'];

      // Reset answered questions for the next section
      _initializeAnsweredQuestions();
    });
  }

  void markQuestionAnswered(int index, bool isCorrect) {
    setState(() {
      if (index < _answeredQuestions.length && !_answeredQuestions[index]) {
        _answeredQuestions[index] = true;
        if (isCorrect) {
          sectionScores[questions[currentQuestionIndex]['section'] - 1]++;
          totalScore++;
        }
      }
    });
  }

  Widget _buildProgressIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ความคืบหน้า',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: currentQuestionIndex / questions.length,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'ข้อที่ ${currentQuestionIndex + 1} จาก ${questions.length}',
            style: TextStyle(
              fontSize: 14,
              color: secondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.score, color: accentColor, size: 28),
              const SizedBox(height: 4),
              Text(
                'คะแนนรวม',
                style: TextStyle(fontSize: 12, color: secondaryColor),
              ),
              Text(
                '$totalScore',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.grey[300],
          ),
          Column(
            children: [
              Icon(Icons.bookmarks, color: accentColor, size: 28),
              const SizedBox(height: 4),
              Text(
                'หมวดหมู่',
                style: TextStyle(fontSize: 12, color: secondaryColor),
              ),
              Text(
                '$_currentSection/11',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(Map<String, dynamic> question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              sectionIcons[question['section']] ?? Icons.help_outline,
              color: accentColor,
              size: 32,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ส่วนที่ ${question['section']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  question['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstructionCard(String instructions) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.amber[200]!),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.amber[700],
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              instructions,
              style: TextStyle(
                fontSize: 16,
                color: Colors.amber[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'คำถาม',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'คำตอบของผู้ทดสอบ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: secondaryColor,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: textAnswerController,
            decoration: InputDecoration(
              hintText: 'พิมพ์คำตอบหรือบันทึกการทำของผู้ทดสอบ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: accentColor, width: 2),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            maxLines: 3,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreButton(int score, int maxScore) {
    Color buttonColor;
    String scoreText;

    if (score == 0) {
      buttonColor = incorrectColor;
      scoreText = 'คะแนน: 0 (ไม่ถูกต้อง)';
    } else if (score == maxScore) {
      buttonColor = correctColor;
      scoreText = 'คะแนน: $score (ถูกต้องทั้งหมด)';
    } else {
      buttonColor = neutralColor;
      scoreText = 'คะแนน: $score';
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _answeredQuestions.contains(true)
            ? null
            : () => nextQuestion(score),
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 2,
        ),
        child: Text(
          scoreText,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSubQuestionItem(int index, Map<String, dynamic> questionItem) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            questionItem['question'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: 'พิมพ์คำตอบของผู้ทดสอบ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[300]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: accentColor, width: 2),
              ),
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (value) {
              setState(() {
                _answeredQuestions[index] = value.isNotEmpty;
              });
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    markQuestionAnswered(index, true);
                    if (_answeredQuestions.every((answered) => answered)) {
                      int correctCount = 0;
                      for (int i = 0; i < _answeredQuestions.length; i++) {
                        if (_answeredQuestions[i]) {
                          correctCount++;
                        }
                      }
                      nextQuestion(correctCount);
                    }
                  },
                  icon: const Icon(Icons.check_circle),
                  label: const Text('ถูก (1 คะแนน)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: correctColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    markQuestionAnswered(index, false);
                    if (_answeredQuestions.every((answered) => answered)) {
                      nextQuestion(0);
                    }
                  },
                  icon: const Icon(Icons.cancel),
                  label: const Text('ผิด (0 คะแนน)'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: incorrectColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildScoreButtons() {
    final Map<String, dynamic> currentQuestion =
        questions[currentQuestionIndex];
    final int maxScore = currentQuestion['maxScore'] ?? 0;

    List<Widget> buttons = [];

    for (int i = 0; i <= maxScore; i++) {
      buttons.add(_buildScoreButton(i, maxScore));
    }

    return Column(children: buttons);
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final Map<String, dynamic> currentQuestion =
        questions[currentQuestionIndex];

    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "แบบทดสอบ MMSE-Thai 2002",
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
              Navigator.pop(context);
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
      body: Container(
        color: backgroundColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProgressIndicator(),
                _buildScoreCard(),
                _buildSectionHeader(currentQuestion),
                if (currentQuestion.containsKey('instructions'))
                  _buildInstructionCard(currentQuestion['instructions']),
                if (currentQuestion.containsKey('questions'))
                  ...List.generate(
                    currentQuestion['questions'].length,
                    (index) => _buildSubQuestionItem(
                      index,
                      currentQuestion['questions'][index],
                    ),
                  )
                else
                  Column(
                    children: [
                      _buildQuestionCard(currentQuestion['question']),
                      if (currentQuestion.containsKey('needInput') &&
                          currentQuestion['needInput'])
                        _buildTextField(),
                      _buildScoreButtons(),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
