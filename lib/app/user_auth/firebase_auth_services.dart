import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
