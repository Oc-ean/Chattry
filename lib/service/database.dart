import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  /// reference for collection...
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  /// saving user data....
  Future savingUsersData(
    String fullName,
    String email,
  ) async {
    return await userCollection.doc(uid).set({
      "name": fullName,
      "email": email,
      "group": [],
      "profile-Pic": " ",
      "uid": uid,
      "date": DateTime.now(),
    });
  }

  /// getting user data....
  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();
    return snapshot;
  }

  /// getting user group....
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }

  /// creating a group....
  Future createGroups(
    String userName,
    String id,
    String groupName,
  ) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": " ",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": " ",
      "recentMessage": " ",
      "recentMessageSender": " ",
    });

    /// updating member....
    await groupDocumentReference.update({
      "members": FieldValue.arrayUnion(
        ["${uid}_$userName"],
      ),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      "group":
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

  /// getting chat .....
  getChat(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy(
          "time",
        )
        .snapshots();
  }

  /// getting the group admin....
  Future getGroupAdmin(String groupId) async {
    DocumentReference documentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot['admin'];
  }

  /// getting group member...
  getGroupMember(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  /// searching for group by name....
  searchByName(String groupName) {
    return groupCollection.where("groupName", isEqualTo: groupName).get();
  }

  /// to keep if user is available...
  Future<bool> isUserJoined(String groupName, groupId, userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['group'];
    if (groups.contains('${groupId}_$groupName')) {
      return true;
    } else {
      return false;
    }
  }

  /// to toggle group join or exit....
  Future toggleGroupJoin(
      String groupId, String userName, String groupName) async {
    /// document reference....
    DocumentReference documentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    List<dynamic> groups = await documentSnapshot['group'];

    if (groups.contains('${groupId}_$groupName')) {
      await documentReference.update({
        'group': FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayRemove(["${uid}_${userName}"])
      });
    } else {
      await documentReference.update({
        'group': FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        'members': FieldValue.arrayUnion(["${uid}_${userName}"])
      });
    }
  }

  /// send message...
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection('messages').add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage": chatMessageData['message'],
      'recentMessageSender': chatMessageData['sender'],
      "recentMessageTime": chatMessageData['time'].toString(),
    });
  }

  /// delete function.....
  Future<void> deleteMessage(
      {required String groupId, required String messageId}) async {
    await FirebaseFirestore.instance
        .collection("groups")
        .doc(groupId)
        .collection("messages")
        .doc(messageId)
        .delete()
        .whenComplete(() {
      print("========>Deleted $groupId Successfully<========");
      print({"groupId": groupId, "messageId": messageId});
      print("========>Deleted $groupId Successfully<========");
    });
  }

  Future<void> deleteChat({
    required String userId,
    required String messageId,
    required String chatId,
    required String lastMsg,
  }) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('messages')
        .doc(messageId)
        .collection('chats')
        .doc(chatId)
        .delete()
        .whenComplete(() {
      print('=====>Deleted $userId successufully<==========');
      print({'userId': userId, 'messages': messageId, 'chats': chatId}
          .toString());
      print('======>Deleted $userId successfully<==========');
    });
  }
}
