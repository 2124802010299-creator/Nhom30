import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question.dart';
import 'online_question_repository.dart';
import 'offline_question_repository.dart';

class QuestionRepository {
  static Future<List<Question>> load({
    required String category,
    required bool online,
  }) async {
    // ===== ONLINE → FIRESTORE =====
    if (online) {
      final snapshot = await FirebaseFirestore.instance
          .collection('questions')
          .where('category', isEqualTo: category)
          .get();

      return snapshot.docs
          .map((doc) => Question.fromMap(doc.id, doc.data()))
          .toList();
    }

    // ===== OFFLINE → ASSETS JSON =====
    return OfflineQuestionRepository.load(
      category: category,
    );
  }
}
