import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/question.dart';

class OnlineQuestionRepository {
  static const String apiUrl =
      'https://raw.githubusercontent.com/letuan1912/quiz-data/main/questions.json';

  static Future<List<Question>> fetchByCategory(String category) async {
    final res = await http.get(Uri.parse(apiUrl));

    if (res.statusCode != 200) {
      throw Exception('Không tải được dữ liệu');
    }

    final Map<String, dynamic> data =
    json.decode(utf8.decode(res.bodyBytes));

    final List list = data[category] ?? [];
    return list.map((e) => Question.fromJson(e)).toList();
  }
}
