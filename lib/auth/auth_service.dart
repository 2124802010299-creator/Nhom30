import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<User?> register(String email, String password) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = credential.user;
    if (user != null) {
      await _db.collection('users').doc(user.uid).set({
        'email': email,
        'role': email == 'admin@gmail.com' ? 'admin' : 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return user;
  }

  Future<User?> login(String email, String password) async {
    final credential =
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
