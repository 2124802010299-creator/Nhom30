import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';
// Thay 'nhom30_main' bằng tên gói thực tế của bạn

import '../models/question.dart';
import '../services/local_storage.dart';

// Đây là StatefulWidget: Cấu trúc ngoài giữ các giá trị truyền vào
class ResultPage extends StatefulWidget {
  final int score;
  final int total;
  final String category;
  final List<Question> questions;
  final List<int?> userAnswers;

  // Constructor vẫn giữ nguyên final
  const ResultPage({
    super.key,
    required this.score,
    required this.total,
    required this.category,
    required this.questions,
    required this.userAnswers,
  });

  @override
  State<ResultPage> createState() => _ResultPageState();
}

// Đây là State: Nơi chứa logic và các hàm thay đổi trạng thái
class _ResultPageState extends State<ResultPage> {
  // Khởi tạo các Service
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Hàm xác định danh hiệu dựa trên điểm số
  Map<String, dynamic> getRankInfo(int score) {
    if (score >= 100) {
      return {'rank': '🌟 HUYỀN THOẠI', 'color': Colors.purple, 'icon': Icons.stars};
    } else if (score >= 80) {
      return {'rank': '💎 KIM CƯƠNG', 'color': Colors.blueAccent, 'icon': Icons.diamond};
    } else if (score >= 50) {
      return {'rank': '🥇 VÀNG', 'color': Colors.orange, 'icon': Icons.emoji_events};
    } else if (score >= 30) {
      return {'rank': '🥈 BẠC', 'color': Colors.grey, 'icon': Icons.military_tech};
    } else {
      return {'rank': '🥉 ĐỒNG', 'color': Colors.brown, 'icon': Icons.workspace_premium};
    }
  }
  // Hàm initState() được gọi NGAY LẦN ĐẦU tiên khi widget được tạo
  @override
  void initState() {
    super.initState();
    _saveUserScore(); // Gọi hàm lưu điểm
  }

  // Logic Lưu Điểm lên Firestore
  void _saveUserScore() async {
    // Lưu vào máy đầy đủ chi tiết để sau này xem lại
    await LocalStorage.saveToHistory(
      category: widget.category,
      score: widget.score,
      questions: widget.questions,
      userAnswers: widget.userAnswers,
    );

    // Lưu điểm cao nhất (như cũ)
    await LocalStorage.saveHighScore(widget.score);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _firestoreService.saveHighScore(
        userId: user.uid,
        email: user.email ?? '',
        score: widget.score,
      );
    }
  }

  // Hàm build hiển thị giao diện
  @override
  Widget build(BuildContext context) {
    final passed = widget.score / widget.total >= 0.5;
    final rankData = getRankInfo(widget.score); // Lấy thông tin rank

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Hiển thị Icon theo Rank
            Icon(
              rankData['icon'],
              size: 100,
              color: rankData['color'],
            ),
            const SizedBox(height: 10),
            // Hiển thị tên Rank
            Text(
              'Hạng: ${rankData['rank']}',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: rankData['color']
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Your Score',
              style: Theme
                  .of(context)
                  .textTheme
                  .titleLarge,
            ),
            Text(
              '${widget.score} / ${widget.total}',
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Play Again'),
            ),
          ],
        ),
      ),
    );
  }
}