import 'package:cloud_firestore/cloud_firestore.dart';

class MUser {
  final String? id;
  final String? uid;
  final String? displayName;
  final String? quote;
  final String? profession;
  final String? avatarUrl;

  MUser(
      {this.id,
      this.uid,
      this.displayName,
      this.quote,
      this.profession,
      this.avatarUrl});
  factory MUser.fromDocument(data, uid) {
    return MUser(
      id: uid,
      avatarUrl: data['avatar_url'],
      displayName: data['display_name'],
      profession: data['profession'],
      quote: data['quote'],
      uid: data['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'quote': quote,
      'profession': profession,
      'display_name': displayName,
      'avatar_url': avatarUrl,
    };
  }
}
