import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/question.dart';

class QuestionService {
  static Future<List<Question>> loadQuestions() async {
    final data = await rootBundle.loadString('assets/cau_hoi.json');
    final List list = json.decode(data);
    return list.map((e) => Question.fromJson(e)).toList();
  }
}
