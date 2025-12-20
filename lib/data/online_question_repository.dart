import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question.dart';

class OnlineQuestionRepository {
  static Future<List<Question>> fetchByCategory(String category) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('questions')
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs
        .map((doc) => Question.fromMap(doc.id, doc.data()))
        .toList();
  }
}
