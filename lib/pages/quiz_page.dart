import 'package:flutter/material.dart';
import '../data/question_repository.dart';
import '../models/question.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final bool online;
  final String category;

  const QuizPage({
    super.key,
    required this.category,
    required this.online,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // ===== STATE =====
  List<Question> questions = [];
  List<int?> userAnswers = [];
  int index = 0;
  int score = 0;
  int? selected;
  int attempts = 0;

  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    load();
  }

  // ===== LOAD QUESTIONS =====
  Future<void> load() async {
    try {
      setState(() {
        loading = true;
        error = null;
      });

      questions = await QuestionRepository.load(
        category: widget.category,
        online: widget.online,
      );

      if (questions.isEmpty) {
        error = 'Không có câu hỏi cho chủ đề này';
      }
    } catch (e) {
      error = 'Lỗi tải câu hỏi';
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  // ===== SELECT ANSWER =====
  void selectAnswer(int i) {
    if (selected != null) return;

    setState(() {
      selected = i;
      if (questions[index].correctIndex == i) {
        if (attempts == 0) score++;
      } else {
        attempts++;
      }
    });
  }

  // ===== RETRY =====
  void retryQuestion() {
    setState(() => selected = null);
  }

  // ===== NEXT =====
  void nextQuestion() {
    userAnswers.add(selected);

    if (index + 1 < questions.length) {
      setState(() {
        index++;
        selected = null;
        attempts = 0;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => ResultPage(
            score: score * 10,
            total: questions.length * 10,
            category: widget.category,
            questions: questions,
            userAnswers: userAnswers,
          ),
        ),
      );
    }
  }

  // ===== ANSWER COLOR =====
  Color answerColor(int i) {
    if (selected == null) return Colors.indigo;
    if (i == questions[index].correctIndex) return Colors.green;
    if (i == selected) return Colors.red;
    return Colors.grey.shade400;
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error!, style: const TextStyle(color: Colors.red)),
              ElevatedButton(onPressed: load, child: const Text('Thử lại')),
            ],
          ),
        ),
      );
    }

    final q = questions[index];

    return Scaffold(
      appBar: AppBar(
        title: Text('Câu ${index + 1}/${questions.length}'),
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== QUESTION =====
            Text(
              q.content,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            // ===== ANSWERS =====
            ...List.generate(
              q.options.length,
                  (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: answerColor(i),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => selectAnswer(i),
                  child: Text(
                    q.options[i],
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // ===== CONTROLS =====
            Column(
              children: [
                if (selected != null) ...[
                  if (selected != q.correctIndex)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: retryQuestion,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Làm lại'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                            ),
                            onPressed: nextQuestion,
                            child: const Text('Bỏ qua'),
                          ),
                        ),
                      ],
                    )
                  else
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        onPressed: nextQuestion,
                        child: Text(
                          index + 1 < questions.length
                              ? 'Câu tiếp theo'
                              : 'Xem kết quả',
                        ),
                      ),
                    ),
                ] else
                  const Text(
                    'Chọn một đáp án để tiếp tục',
                    style: TextStyle(color: Colors.grey),
                  ),
              ],
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
