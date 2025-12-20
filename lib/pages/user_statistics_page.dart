import 'package:flutter/material.dart';
import '../services/user_stats_service.dart';

class UserStatisticsPage extends StatelessWidget {
  const UserStatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = UserStatsService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê người dùng'),
      ),
      body: FutureBuilder<List<int>>(
        future: Future.wait([
          service.totalUsers(),
          service.totalAdmins(),
          service.totalNormalUsers(),
        ]),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final total = snapshot.data![0];
          final admins = snapshot.data![1];
          final users = snapshot.data![2];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _card('👥 Tổng người dùng', total, Colors.blue),
                _card('👑 Admin', admins, Colors.red),
                _card('🙂 Người dùng thường', users, Colors.green),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _card(String title, int value, Color color) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color,
          child: Text(
            value.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
