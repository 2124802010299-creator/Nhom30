import 'package:flutter/material.dart';

// ===== THÊM 2 IMPORT NÀY =====
import '../auth/auth_service.dart';
import '../auth/login_page.dart';

// ===== IMPORT CŨ =====
import '../leaderboard/leaderboard_page.dart';
import 'category_page.dart';
import 'statistics_page.dart';
import 'history_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // ===== APPBAR + LOGOUT =====
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            tooltip: 'Đăng xuất',
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().logout();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                    (route) => false,
              );
            },
          ),
        ],
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFB71C1C), // Đỏ Noel
              Color(0xFF1B5E20), // Xanh Thông
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // --- BIỂU TƯỢNG ---
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.card_giftcard,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    '🎄 Christmas Quiz 🎄',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),

                  // --- MENU ---
                  _menuButton(
                    context,
                    label: 'CHƠI ONLINE',
                    icon: Icons.language,
                    color: Colors.redAccent,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoryPage(online: true),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  _menuButton(
                    context,
                    label: 'CHƠI OFFLINE',
                    icon: Icons.videogame_asset_outlined,
                    color: Colors.white,
                    textColor: const Color(0xFF1B5E20),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CategoryPage(online: false),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  _menuButton(
                    context,
                    label: 'THỐNG KÊ CÁ NHÂN',
                    icon: Icons.bar_chart_rounded,
                    color: Colors.orangeAccent,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const StatisticsPage(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                  _menuButton(
                    context,
                    label: 'BẢNG XẾP HẠNG',
                    icon: Icons.emoji_events,
                    color: Colors.amber,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LeaderboardPage(),
                        ),
                      );
                    },
                  ),

                  _menuButton(
                    context,
                    label: 'LỊCH SỬ LÀM BÀI',
                    icon: Icons.history_rounded,
                    color: Colors.blueGrey,
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HistoryPage(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),

                  const Text(
                    '🎅 Ho Ho Ho! Merry Christmas!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- BUTTON BUILDER ---
  Widget _menuButton(
      BuildContext context, {
        required String label,
        required IconData icon,
        required Color color,
        required VoidCallback onPressed,
        Color textColor = Colors.white,
      }) {
    return SizedBox(
      width: 280,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: textColor,
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}
