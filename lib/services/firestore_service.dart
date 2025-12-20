import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collection lưu điểm cao
  final CollectionReference highScores =
  FirebaseFirestore.instance.collection('high_scores');

  /// Lưu hoặc cập nhật điểm cao nhất của user
  Future<void> saveHighScore({
    required String userId,
    required String email,
    required int score,
  }) async {
    final docRef = highScores.doc(userId);
    final doc = await docRef.get();

    final data = {
      'uid': userId,
      'email': email,
      'score': score,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    if (doc.exists) {
      final currentScore = (doc.data() as Map<String, dynamic>)['score'] ?? 0;
      if (score > currentScore) {
        await docRef.update(data);
      }
    } else {
      await docRef.set(data);
    }
  }

  /// Lấy bảng xếp hạng top 10
  Stream<QuerySnapshot> getLeaderboard() {
    return highScores
        .orderBy('score', descending: true)
        .limit(10)
        .snapshots();
  }
}
