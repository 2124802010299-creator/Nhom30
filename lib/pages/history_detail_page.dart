import 'package:flutter/material.dart';

class HistoryDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const HistoryDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final List questions = data['details'];
    final List userAnswers = data['userAnswers'];

    return Scaffold(
      appBar: AppBar(title: Text('Chi tiết: ${data['category']}')),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (ctx, i) {
          final q = questions[i];
          final int? selected = userAnswers[i];
          final int correct = q['correctIndex'];

          return Card(
            margin: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Câu ${i + 1}: ${q['question']}',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 10),
                  ...List.generate(q['answers'].length, (idx) {
                    Color color = Colors.black;
                    IconData? icon;

                    if (idx == correct) {
                      color = Colors.green;
                      icon = Icons.check_circle;
                    } else if (idx == selected && selected != correct) {
                      color = Colors.red;
                      icon = Icons.cancel;
                    }

                    return ListTile(
                      leading: Icon(icon, color: color),
                      title: Text(q['answers'][idx], style: TextStyle(color: color)),
                      dense: true,
                    );
                  }),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}