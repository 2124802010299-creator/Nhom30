import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/question_service.dart';

class QuestionManagePage extends StatelessWidget {
  QuestionManagePage({super.key});

  final service = QuestionService();

  // 👉 Category mặc định cho Admin (bạn có thể đổi)
  final List<String> categories = [
    'toan_hoc',
    'lich_su',
    'tam_linh',
    'cong_nghe',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý câu hỏi')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openForm(context),
      ),
      body: StreamBuilder<List<Question>>(
        stream: service.getQuestions(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final questions = snapshot.data!;

          if (questions.isEmpty) {
            return const Center(child: Text('Chưa có câu hỏi nào'));
          }

          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (_, i) {
              final q = questions[i];
              return Card(
                child: ListTile(
                  title: Text(q.content),
                  subtitle: Text(
                    'Category: ${q.category}\n'
                        'Đáp án đúng: ${q.options[q.correctIndex]}',
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _openForm(context, question: q),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => service.deleteQuestion(q.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ===== FORM ADD / EDIT =====
  void _openForm(BuildContext context, {Question? question}) {
    final contentCtrl =
    TextEditingController(text: question?.content ?? '');

    final optionsCtrls = List.generate(
      4,
          (i) => TextEditingController(
        text: question?.options[i] ?? '',
      ),
    );

    int correctIndex = question?.correctIndex ?? 0;

    // 👉 Category (giữ cũ nếu sửa, mặc định nếu thêm)
    String selectedCategory =
        question?.category ?? categories.first;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(question == null ? 'Thêm câu hỏi' : 'Sửa câu hỏi'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              // ===== CATEGORY =====
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration:
                const InputDecoration(labelText: 'Category'),
                items: categories
                    .map(
                      (c) => DropdownMenuItem(
                    value: c,
                    child: Text(c),
                  ),
                )
                    .toList(),
                onChanged: (v) => selectedCategory = v!,
              ),

              const SizedBox(height: 10),

              // ===== CONTENT =====
              TextField(
                controller: contentCtrl,
                decoration:
                const InputDecoration(labelText: 'Nội dung câu hỏi'),
              ),

              const SizedBox(height: 10),

              // ===== OPTIONS =====
              for (int i = 0; i < 4; i++)
                TextField(
                  controller: optionsCtrls[i],
                  decoration: InputDecoration(
                    labelText: 'Đáp án ${i + 1}',
                  ),
                ),

              const SizedBox(height: 10),

              // ===== CORRECT INDEX =====
              DropdownButtonFormField<int>(
                value: correctIndex,
                decoration:
                const InputDecoration(labelText: 'Đáp án đúng'),
                items: List.generate(
                  4,
                      (i) => DropdownMenuItem(
                    value: i,
                    child: Text('Đáp án ${i + 1}'),
                  ),
                ),
                onChanged: (v) => correctIndex = v!,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () async {
              final q = Question(
                id: question?.id ?? '',
                category: selectedCategory, // ✅ FIX CHÍNH
                content: contentCtrl.text,
                options: optionsCtrls.map((e) => e.text).toList(),
                correctIndex: correctIndex,
              );

              if (question == null) {
                await service.addQuestion(q);
              } else {
                await service.updateQuestion(q);
              }

              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }
}
