import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question.dart';

class OfflineQuestionRepository {
  static Future<List<Question>> load({
    required String category,
  }) async {
    final data = await rootBundle.loadString('assets/cau_hoi.json');
    final List list = json.decode(data);

    return list.asMap().entries.map((entry) {
      final i = entry.key;
      final e = entry.value;

      return Question(
        id: 'offline_$i',
        category: category,
        content: e['content'],
        options: List<String>.from(e['options']),
        correctIndex: e['correctIndex'],
      );
    }).toList();
  }
}
