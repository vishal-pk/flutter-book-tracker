import 'package:book_tracker/modal/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<void> createUser(String displayName, BuildContext context) async {
  final userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid;
  MUser user = MUser(displayName: displayName, uid: uid);
  // Map<String, dynamic> user = {
  //   'display_name': displayName,
  //   'uid': uid,
  //   'quote': 'life is hreat',
  //   'avatar_url': null,
  //   'profession': 'job'
  // };
  userCollectionReference.add(user.toMap());
}
