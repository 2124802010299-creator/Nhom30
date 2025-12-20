import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/local_storage.dart';
import 'history_detail_page.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> history = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  void _loadHistory() async {
    final data = await LocalStorage.getHistory();
    setState(() {
      history = data;
    });
  }

  // Hàm xóa tất cả
  void _clearAll() async {
    await LocalStorage.clearAllHistory();
    _loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch sử làm bài'),
        backgroundColor: const Color(0xFFB71C1C),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: () {
              // Hiện thông báo xác nhận trước khi xóa hết
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Xóa tất cả?'),
                  content: const Text('Bạn có chắc muốn xóa toàn bộ lịch sử không?'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
                    TextButton(onPressed: () {
                      _clearAll();
                      Navigator.pop(ctx);
                    }, child: const Text('Xóa', style: TextStyle(color: Colors.red))),
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: history.isEmpty
          ? const Center(child: Text('Chưa có lịch sử nào.'))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          final date = DateTime.parse(item['date']);

          return Dismissible(
            key: Key(item['date']), // Dùng ngày làm key duy nhất
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) async {
              await LocalStorage.deleteHistoryItem(index);
              setState(() {
                history.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(' Đã xóa một mục lịch sử')),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.quiz, color: Colors.white),
                ),
                title: Text('${item['category']} - ${item['score']} điểm'),
                subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(date)),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HistoryDetailPage(data: item),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}