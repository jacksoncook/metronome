import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metronome/models/models.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  Future<void> createUser(
    String email,
    String name,
  ) async {
    return _firestore.collection("users").document(email).setData({
      'email': email,
      'name': name,
      'payer': false,
    });
  }

  Future<void> createBeat(
    String beatName,
    Beat beat,
  ) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final CollectionReference beatFragmentsRef = _firestore
          .collection('beats')
          .document(beatName)
          .collection('fragments');
      var counter = 0;
      for (final beatFragment in beat.beatFragments) {
        final DocumentReference fragmentRef =
            beatFragmentsRef.document(counter.toString());
        final Map<String, dynamic> data = beatFragment.toMap();
        counter++;
        await tx.set(fragmentRef, data);
      }
      return;
    };
    return _firestore.runTransaction(createTransaction).catchError((e) {
      print('dart error: $e');
      return;
    });
  }
}
