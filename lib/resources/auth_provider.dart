import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> register(String registerEmail, String registerPassword) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerEmail, password: registerPassword);
  }

  Future<void> signIn(String loginEmail, String loginPassword) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: loginEmail, password: loginPassword);
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currUser = await _firebaseAuth.currentUser();
    return currUser != null;
  }
}
