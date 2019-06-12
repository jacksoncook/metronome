import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> register(
      String registerEmail, String registerPassword) async {
    final FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: registerEmail, password: registerPassword);
    return user;
  }

  Future<FirebaseUser> signIn(String loginEmail, String loginPassword) async {
    final FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: loginEmail, password: loginPassword);
    return user;
  }

  Future<void> signOut() async {
    return Future.wait([
      _auth.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currUser = await _auth.currentUser();
    return currUser != null;
  }
}
