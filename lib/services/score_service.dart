import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScoreService {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveScore({
    required int score,
    required String category,
  }) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('scores').add({
      'uid': user.uid,
      'email': user.email,
      'score': score,
      'category': category,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
