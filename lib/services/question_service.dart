import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/question.dart';

class QuestionService {
  final _db = FirebaseFirestore.instance.collection('questions');

  Stream<List<Question>> getQuestions() {
    return _db.snapshots().map(
          (snapshot) => snapshot.docs
          .map((doc) => Question.fromMap(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> addQuestion(Question q) async {
    await _db.add(q.toMap());
  }

  Future<void> updateQuestion(Question q) async {
    await _db.doc(q.id).update(q.toMap());
  }

  Future<void> deleteQuestion(String id) async {
    await _db.doc(id).delete();
  }
}
