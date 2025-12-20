import 'package:flutter/material.dart';

// ===== AUTH =====
import '../auth/auth_service.dart';
import '../auth/login_page.dart';

// ===== ADMIN FEATURES =====
import 'question_manage_page.dart';
import 'user_statistics_page.dart';
import '../utils/seed_questions.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
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

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                '👑 QUẢN TRỊ HỆ THỐNG',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // ===== CRUD CÂU HỎI =====
              _adminButton(
                context,
                icon: Icons.quiz,
                label: 'Quản lý câu hỏi',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => QuestionManagePage(),
                    ),
                  );
                },
              ),

              // ===== SEED DỮ LIỆU =====
              _adminButton(
                context,
                icon: Icons.cloud_upload,
                label: 'Seed lại TOÀN BỘ câu hỏi',
                onTap: () async {
                  await SeedQuestions.seedAll();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Đã seed lại 4 chủ đề'),
                    ),
                  );
                },
              ),

              // ===== THỐNG KÊ NGƯỜI DÙNG (THẬT) =====
              _adminButton(
                context,
                icon: Icons.people,
                label: 'Thống kê người dùng',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const UserStatisticsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== ADMIN BUTTON =====
  Widget _adminButton(
      BuildContext context, {
        required IconData icon,
        required String label,
        required VoidCallback onTap,
      }) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
