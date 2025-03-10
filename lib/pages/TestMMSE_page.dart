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
        {'question': '2.1 สถานที่ตรงนี้เรียกว่าอะไร', 'maxScore': 1},
        {'question': '2.2 ขณะนี้อยู่ชั้นที่เท่าไรของตัวอาคาร', 'maxScore': 1},
        {'question': '2.3 ที่นี่อยู่ในอำเภออะไร', 'maxScore': 1},
        {'question': '2.4 ที่นี่จังหวัดอะไร', 'maxScore': 1},
        {'question': '2.5 ที่นี่ภาคอะไร', 'maxScore': 1},
      ],
      'instructions': 'ตอบถูกต้องได้ 1 คะแนน ตอบผิดได้ 0 คะแนน',
    },
    // Section 3: Registration
    {
      'section': 3,
      'title': 'การบันทึกความจำ',
      'question':
          'ทดสอบการบันทึกความจำโดยให้จำชื่อของ 3 อย่าง:\nดอกไม้ แม่น้ำ รถไฟ',
      'instructions':
          'จำได้ทั้ง 3 คำได้ 3 คะแนน, จำได้ 2 คำได้ 2 คะแนน, จำได้ 1 คำได้ 1 คะแนน, จำไม่ได้เลยได้ 0 คะแนน',
      'maxScore': 3,
      'needInput': true,
    },
    // Section 4: Attention or Calculation
    {
      'section': 4,
      'title': 'ทดสอบสมาธิโดยให้คิดเลขในใจ',
      'question': '100 - 7 = ?\n93 - 7 = ?\n86 - 7 = ?\n79 - 7 = ?\n72 - 7 = ?',
      'instructions':
          'คิดลบเลข 7 จาก 100 ไปเรื่อยๆ 5 ครั้ง ตอบถูกแต่ละครั้งได้ 1 คะแนน',
      'maxScore': 5,
      'needInput': true,
    },
    // Section 5: Recall
    {
      'section': 5,
      'title': 'ทดสอบความจำระยะสั้น',
      'question': 'จงบอกชื่อสิ่งของ 3 อย่างที่ให้จำไว้เมื่อสักครู่',
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
        {'question': '6.1 สิ่งนี้เรียกว่าอะไร (ดินสอ)', 'maxScore': 1},
        {'question': '6.2 สิ่งนี้เรียกว่าอะไร (นาฬิกา)', 'maxScore': 1},
      ],
      'instructions': 'ตอบถูกต้องได้ 1 คะแนน ตอบผิดได้ 0 คะแนน',
    },
    // Section 7: Repetition
    {
      'section': 7,
      'title': 'การพูดซ้ำคำที่ได้ยิน',
      'question': 'กรุณาพูดตามประโยค "ใครใคร่ขายไก่ไข่"',
      'instructions': 'พูดซ้ำได้ถูกต้องได้ 1 คะแนน พูดผิดได้ 0 คะแนน',
      'maxScore': 1,
      'needInput': true,
    },
    // Section 8: Verbal command
    {
      'section': 8,
      'title': 'การเข้าใจความหมายและทำตามคำสั่ง',
      'question':
          'ให้ทำตามคำสั่งต่อไปนี้:\n1. รับกระดาษด้วยมือขวา\n2. พับครึ่งด้วยมือทั้ง 2 ข้าง\n3. วางไว้ที่พื้น',
      'instructions': 'ทำถูกต้องแต่ละขั้นตอนได้ 1 คะแนน',
      'maxScore': 3,
      'needInput': true,
    },
    // Section 9: Written command
    {
      'section': 9,
      'title': 'การอ่านและเข้าใจความหมาย',
      'question': 'กรุณาอ่านและทำตามคำสั่ง "หลับตา"',
      'instructions': 'อ่านและทำตามได้ถูกต้องได้ 1 คะแนน',
      'maxScore': 1,
      'needInput': true,
    },
    // Section 10: Writing
    {
      'section': 10,
      'title': 'การเขียนภาษาอย่างมีความหมาย',
      'question':
          'ให้เขียนข้อความอะไรก็ได้ที่อ่านแล้วรู้เรื่องหรือมีความหมาย 1 ประโยค',
      'instructions': 'เขียนประโยคที่มีความหมายได้ 1 คะแนน',
      'maxScore': 1,
      'needInput': true,
    },
    // Section 11: Visuoconstruction
    {
      'section': 11,
      'title': 'ความสัมพันธ์ระหว่างตากับมือ',
      'question': 'ให้วาดภาพรูปห้าเหลี่ยมซ้อนกัน',
      'instructions': 'วาดได้ถูกต้องได้ 1 คะแนน',
      'maxScore': 1,
      'needInput': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnsweredQuestions();
  }

  void _initializeAnsweredQuestions() {
    if (questions.isNotEmpty && currentQuestionIndex < questions.length) {
      _answeredQuestions = List.filled(
          questions[currentQuestionIndex]['questions']?.length ?? 1, false);
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
      if (index < _answeredQuestions.length) {
        _answeredQuestions[index] = true;
        if (isCorrect) {
          sectionScores[questions[currentQuestionIndex]['section'] - 1]++;
          totalScore++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentQuestionIndex >= questions.length) {
      return const Center(child: CircularProgressIndicator());
    }

    final question = questions[currentQuestionIndex];
    final isMultiQuestion = question.containsKey('questions');
    final needsTextInput =
        question.containsKey('needInput') && question['needInput'];

    return WillPopScope(
      onWillPop: () async {
        if (currentQuestionIndex > 0) {
          setState(() {
            currentQuestionIndex--;
            _currentSection = questions[currentQuestionIndex]['section'];
          });
          return false; // Prevent default back navigation
        }
        return true; // Allow default back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF30444E),
          title: Text(
            ('ข้อที่ ${currentQuestionIndex + 1} จาก ${questions.length}'),
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 24,
            ),
            onPressed: () {
              if (currentQuestionIndex > 0) {
                setState(() {
                  currentQuestionIndex--;
                  _currentSection = questions[currentQuestionIndex]['section'];
                });
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ส่วนที่ ${question['section']}: ${question['title']}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                if (!isMultiQuestion) ...[
                  Text(
                    question['question'],
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'คำแนะนำ: ${question['instructions']}',
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  if (needsTextInput) ...[
                    TextField(
                      controller: textAnswerController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'คำตอบของผู้ทดสอบ',
                        hintText: 'พิมพ์คำตอบหรือบันทึกการทำของผู้ทดสอบ',
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 20),
                  ],
                  Center(
                    child: Column(
                      children: List.generate(
                        question['maxScore'] + 1,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Fix: Don't check if already answered
                              // Instead, directly go to next question with the selected score
                              nextQuestion(index);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              minimumSize: const Size(double.infinity, 60),
                              backgroundColor: index == 0
                                  ? Colors.red
                                  : (index == question['maxScore']
                                      ? Colors.green
                                      : Colors.blue),
                            ),
                            child: Text(
                              'คะแนน: $index' +
                                  (index == 0
                                      ? ' (ไม่ถูกต้อง)'
                                      : index == question['maxScore']
                                          ? ' (ถูกต้องทั้งหมด)'
                                          : ''),
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  Text(
                    'คำแนะนำ: ${question['instructions']}',
                    style: const TextStyle(
                        fontSize: 16, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 20),
                  ...List.generate(
                    question['questions'].length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            question['questions'][index]['question'],
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'คำตอบของผู้ทดสอบ',
                              hintText: 'พิมพ์คำตอบของผู้ทดสอบ',
                            ),
                            onChanged: (value) {
                              // Only mark as answered, don't calculate score here
                              setState(() {
                                _answeredQuestions[index] = value.isNotEmpty;
                              });
                            },
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    markQuestionAnswered(index, true);
                                    // Check if all sub-questions are answered
                                    if (_answeredQuestions
                                        .every((answered) => answered)) {
                                      // Calculate total correct answers for this section
                                      int correctCount = 0;
                                      for (int i = 0;
                                          i < _answeredQuestions.length;
                                          i++) {
                                        if (_answeredQuestions[i]) {
                                          correctCount++;
                                        }
                                      }
                                      nextQuestion(correctCount);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                  ),
                                  child: const Text(
                                    'ถูก (1 คะแนน)',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    markQuestionAnswered(index, false);
                                    if (_answeredQuestions
                                        .every((answered) => answered)) {
                                      // Move to next question with 0 score for this question
                                      nextQuestion(0);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: const Text(
                                    'ผิด (0 คะแนน)',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
