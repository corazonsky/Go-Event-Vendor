import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:go_event_vendor/models/UserData.dart';

import 'firestore_path.dart';

class FirestoreService {
  FirestoreService({@required this.uid}) : assert(uid != null);
  final String uid;

  // Create / Update UserData
  Future<void> setUserData(UserDataModel userData) async {
    final path = FirestorePath.userData(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(userData.toMap());
  }

  // Reads the current userData
  Stream<UserDataModel> userDataStream() {
    final path = FirestorePath.userData(uid);
    final reference = FirebaseFirestore.instance.doc(path);
    final snapshots = reference.snapshots();
    return snapshots
        .map((snapshot) => UserDataModel.fromMap(snapshot.data(), uid));
  }
}
