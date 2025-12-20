import 'package:flutter/material.dart';
import '../services/local_storage.dart';
import '../services/firestore_service.dart';


class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  // Hàm tính Rank dựa trên điểm
  String getRank(int score) {
    if (score >= 100) return '🌟 HUYỀN THOẠI';
    if (score >= 80) return '💎 KIM CƯƠNG';
    if (score >= 50) return '🥇 VÀNG';
    if (score >= 30) return '🥈 BẠC';
    return '🥉 ĐỒNG';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Trang trí thanh AppBar màu Giáng sinh cho đồng bộ
      appBar: AppBar(
        title: const Text('Thống Kê Cá Nhân'),
        backgroundColor: const Color(0xFFB71C1C),
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<int>(
        future: LocalStorage.getHighScore(),
        builder: (context, snapshot) {
          // Trạng thái đang tải dữ liệu
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final highScore = snapshot.data ?? 0;
          final rank = getRank(highScore);

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // ĐÃ SỬA: MainAxisAlignment thay vì MainStateAxis
              children: [
                // Hình đại diện giả định
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Color(0xFF1B5E20),
                  child: Icon(Icons.person, size: 70, color: Colors.white),
                ),

                const SizedBox(height: 30),

                // Hiển thị Điểm
                const Text(
                  'ĐIỂM CAO NHẤT',
                  style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1.2),
                ),
                Text(
                  '$highScore',
                  style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB71C1C)
                  ),
                ),

                const SizedBox(height: 20),

                // Hiển thị Rank
                const Text(
                  'DANH HIỆU HIỆN TẠI',
                  style: TextStyle(fontSize: 16, color: Colors.grey, letterSpacing: 1.2),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.orange, width: 2),
                  ),
                  child: Text(
                    rank,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange
                    ),
                  ),
                ),

                const SizedBox(height: 50),

                const Text(
                  '🎅 Chăm chỉ luyện tập để đạt hạng\nHuyền Thoại bạn nhé!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}