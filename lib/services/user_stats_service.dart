import 'package:cloud_firestore/cloud_firestore.dart';

class UserStatsService {
  final _ref = FirebaseFirestore.instance.collection('users');

  Future<int> totalUsers() async {
    final snap = await _ref.get();
    return snap.size;
  }

  Future<int> totalAdmins() async {
    final snap = await _ref.where('role', isEqualTo: 'admin').get();
    return snap.size;
  }

  Future<int> totalNormalUsers() async {
    final snap = await _ref.where('role', isEqualTo: 'user').get();
    return snap.size;
  }
}
