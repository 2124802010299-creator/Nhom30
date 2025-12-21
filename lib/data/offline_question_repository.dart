import 'dart:convert';
import "package:flutter/services.dart";
import '../models/question.dart';

class OfflineQuestionRepository {
  static Future<List<Question>> load({required String category}) async {
    final data = await rootBundle.loadString('assets/cau_hoi.json');
    final List list = json.decode(data);
    return list.map((e) => Question.fromJson(e)).toList();
  }
}
