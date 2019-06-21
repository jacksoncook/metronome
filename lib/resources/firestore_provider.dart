import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metronome/models/models.dart';

class FirestoreProvider {
  Firestore _firestore = Firestore.instance;

  // Write to firestore

  //Writes user to firestore
  Future<void> writeUser(
    String email,
    String name,
  ) async {
    return _firestore.collection("users").document(email).setData({
      'email': email,
      'name': name,
      'payer': false,
    });
  }

  // Writes beat to firestore
  // TODO: Currently parts are stored as string versions of
  // ints.  In the future, this may cause beats to be played
  // in the wrong order in the future.
  Future<void> writeBeat(
    Beat beat,
  ) {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final CollectionReference beatFragmentsRef = _firestore
          .collection('beats')
          .document(beat.beatName)
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

  // Writes group to firestore and updates user's groups
  // Future<void> writeGroup(String groupName, String payingAccount) async {
  //   final TransactionHandler createTransaction = (Transaction tx) async {
  //     _firestore
  //         .collection('groups')
  //         .document(groupName)
  //         .setData({'payingAccount': payingAccount, 'groupName': groupName});
  //     _firestore.collection('users').document('groups')
  //       ..updateData({groupName: true});
  //     return;
  //   };
  //   return _firestore.runTransaction(createTransaction).catchError((e) {
  //     print('dart error: $e');
  //     return;
  //   });
  // }

  // Read from firestore

  // Reads beat from firestore
  // Future<Beat> readBeat(String beatName) async {
  //   final List<BeatFragment> beatFragments = [];
  //   _firestore.collection("songs").document(beatName).get().then((snapshot) => {
  //         snapshot.data.forEach((id, fragment) =>
  //             {beatFragments.add(BeatFragment.fromMap(fragment.data))})
  //       });
  //   return Beat(
  //     beatName: beatName,
  //     beatFragments: beatFragments,
  //   );
  // }

  // // Reads group from firestore
  // Future<Group> readGroup(String groupName) async {
  //   final List<String> songNames = [];
  //   String payingAccount;
  //   _firestore
  //       .collection("groups")
  //       .document(groupName)
  //       .get()
  //       .then((snapshot) => {
  //             payingAccount = snapshot.data['payingAccount'],
  //             snapshot.data['songNames']
  //                 .forEach((songName) => {songNames.add(songName.data)})
  //           });
  //   return Group(
  //     groupName: groupName,
  //     payingAccount: payingAccount,
  //     songNames: songNames,
  //   );
  // }
}
