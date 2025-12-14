import 'package:flutter/material.dart';
import '../data/question_repository.dart';
import '../models/question.dart';

class QuizPage extends StatefulWidget {
  final bool online;
  final String category;

  QuizPage({
    super.key,
    required this.category,
    required this.online,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Question> questions = [];
  int index = 0;
  int score = 0;

  int? selected;

  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    load();
  }

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
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  void selectAnswer(int i) {
    if (selected != null) return;

    setState(() {
      selected = i;
      if (questions[index].correctIndex == i) {
        score++;
      }
    });
  }

  void nextQuestion() {
    if (index + 1 < questions.length) {
      setState(() {
        index++;
        selected = null;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('🎉 Hoàn thành'),
          content: Text('Điểm của bạn: $score / ${questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // đóng dialog
                Navigator.pop(context); // quay lại màn trước
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Color answerColor(int i) {
    if (selected == null) return Colors.indigo;
    if (i == questions[index].correctIndex) return Colors.green;
    if (i == selected) return Colors.red;
    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    // ⏳ LOADING
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // ❌ ERROR / EMPTY
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Lỗi')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                error!,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: load,
                child: const Text('Thử lại'),
              ),
            ],
          ),
        ),
      );
    }

    // ✅ SUCCESS
    final q = questions[index];

    return Scaffold(
      appBar: AppBar(
        title: Text('Câu ${index + 1}/${questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              q.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 24),

            ...List.generate(
              q.answers.length,
                  (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: answerColor(i),
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                  ),
                  onPressed: () => selectAnswer(i),
                  child: Text(
                    q.answers[i],
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selected == null ? null : nextQuestion,
                child: Text(
                  index + 1 < questions.length
                      ? 'Câu tiếp theo'
                      : 'Kết thúc',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
