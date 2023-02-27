import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String fullName;
  String profilePic;

  String uid;

  UserModel(
      {required this.email,
      required this.fullName,
      required this.profilePic,
      required this.uid});

  factory UserModel.fromJson(DocumentSnapshot snapshot) {
    return UserModel(
      email: snapshot['email'],
      fullName: snapshot['fullName'],
      profilePic: snapshot['profile-Pic'],
      uid: snapshot['uid'],
    );
  }
}
