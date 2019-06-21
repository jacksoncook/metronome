import 'firestore_provider.dart';
import 'auth_provider.dart';
import 'package:metronome/models/models.dart';

class Repository {
  final FirestoreProvider _firestoreProvider = FirestoreProvider();
  final AuthProvider _auth = AuthProvider();

  // Cloud Firestore

  // Write to Firestore
  Future<void> writeUser(
    String email,
    String name,
  ) =>
      _firestoreProvider.writeUser(
        email,
        name,
      );

  Future<void> writeBeat(
    Beat beat,
  ) =>
      _firestoreProvider.writeBeat(
        beat,
      );

  // Firebase Authentification methods
  Future<void> register(
    String registerEmail,
    String registerPassword,
  ) =>
      _auth.register(
        registerEmail,
        registerPassword,
      );

  Future<void> signIn(
    String loginEmail,
    String loginPassword,
  ) =>
      _auth.signIn(
        loginEmail,
        loginPassword,
      );
  Future<void> signOut() => _auth.signOut();

  Future<bool> isSignedIn() => _auth.isSignedIn();
}
