import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/question.dart';

class LocalStorage {
  static const _highScoreKey = 'high_score';
  static const _historyKey = 'quiz_history';

  // ===== HIGH SCORE =====
  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }

  static Future<void> saveHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_highScoreKey, score);
  }

  // ===== HISTORY =====
  static Future<void> saveToHistory({
    required String category,
    required int score,
    required List<Question> questions,
    required List<int?> userAnswers,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];

    final record = {
      'category': category,
      'score': score,
      'date': DateTime.now().toIso8601String(),
      'details': questions.map((q) => q.toJson()).toList(),
      'userAnswers': userAnswers,
    };

    history.insert(0, json.encode(record));
    await prefs.setStringList(_historyKey, history);
  }

  static Future<List<Map<String, dynamic>>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    return history
        .map((e) => json.decode(e) as Map<String, dynamic>)
        .toList();
  }

  static Future<void> deleteHistoryItem(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_historyKey) ?? [];
    if (index >= 0 && index < history.length) {
      history.removeAt(index);
      await prefs.setStringList(_historyKey, history);
    }
  }

  static Future<void> clearAllHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}
