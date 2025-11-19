import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'trang_quiz.dart';
import 'trang_chu.dart';

class TrangKetQua extends StatelessWidget {
  final int diem;
  final int tongSoCau;

  const TrangKetQua({
    super.key,
    required this.diem,
    required this.tongSoCau,
  });

  @override
  Widget build(BuildContext context) {
    double tile = diem / tongSoCau;

    IconData icon;
    Color mau;

    if (tile == 1) {
      icon = Icons.emoji_events;
      mau = Colors.yellow.shade700;
    } else if (tile >= 0.7) {
      icon = Icons.sentiment_satisfied_alt;
      mau = Colors.green;
    } else if (tile >= 0.4) {
      icon = Icons.sentiment_neutral;
      mau = Colors.orange;
    } else {
      icon = Icons.sentiment_very_dissatisfied;
      mau = Colors.red;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 90, color: mau),

              const SizedBox(height: 20),

              Text(
                "KẾT QUẢ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "$diem / $tongSoCau",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Điểm của bạn",
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TrangQuiz()),
                  );
                },
                child: const Text("Chơi lại", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),

              const SizedBox(height: 16),

              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const TrangChu()),
                  );
                },
                child: const Text(
                  "Về trang chủ",
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
