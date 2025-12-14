import 'package:flutter/material.dart';
import 'quiz_page.dart';

class CategoryPage extends StatelessWidget {
  final bool online;
  const CategoryPage({super.key, required this.online});

  @override
  Widget build(BuildContext context) {
    final categories = {
      '🧮 Toán học': 'toan_hoc',
      '📜 Lịch sử': 'lich_su',
      '🔮 Tâm linh': 'tam_linh',
      '💻 Công nghệ': 'cong_nghe',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎄 Chọn chủ đề'),
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFDF7F7),
              Color(0xFFE8F5E9),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: categories.entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuizPage(
                        category: e.value,
                        online: online,
                      ),
                    ),
                  );
                },
                child: Text(
                  e.key,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
