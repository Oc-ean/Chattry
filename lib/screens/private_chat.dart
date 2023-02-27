import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/service/database.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/private_message_text_field.dart';
import 'package:simple_messaging_app/utils/private_message_tile.dart';

class PrivateChat extends StatefulWidget {
  final User? currentUser;
  final String? friendId;
  final String? friendName;
  // final String friendImage;
  const PrivateChat(
      {Key? key, this.friendId, this.friendName, this.currentUser})
      : super(key: key);

  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  String email = '';
  String fullName = '';
  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSf().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSf().then((value) {
      setState(() {
        fullName = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Row(
          children: [
            // CircleAvatar(
            //   radius: 20,
            //   backgroundImage: NetworkImage("${friendImage}"),
            // ),
            const SizedBox(
              width: 12,
            ),
            Text(
              widget.friendName!,
              style: const TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/app.png'),
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(widget.currentUser!.uid)
                          .collection('messages')
                          .doc(widget.friendId)
                          .collection('chats')
                          .orderBy("date", descending: true)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.docs.length < 1) {
                            return const Center(
                              child: Text("Say Hi"),
                            );
                          }
                          return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              reverse: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var a = DateTime.parse(snapshot
                                    .data!.docs[index]['date']
                                    .toDate()
                                    .toString());
                                var time = DateFormat(' hh:mm a').format(a);
                                bool isMe = snapshot.data!.docs[index]
                                        ['senderId'] ==
                                    widget.currentUser!.uid;

                                return InkWell(
                                  onLongPress: () async {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            // insetPadding: const EdgeInsets.all(10),
                                            backgroundColor:
                                                Theme.of(context).primaryColor,
                                            title: const Text(
                                              'Delete message',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22),
                                            ),
                                            content: const Text(
                                              'Are you sure you want to delete this message?',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 22),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Cancel',
                                                  style: TextStyle(
                                                      color: Colors.indigo,
                                                      fontSize: 20),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  DatabaseService().deleteChat(
                                                      lastMsg: snapshot
                                                          .data!.docs[index].id,
                                                      userId: widget
                                                          .currentUser!.uid,
                                                      messageId:
                                                          widget.friendId!,
                                                      chatId: snapshot.data!
                                                          .docs[index].id);
                                                  showSnackBar(
                                                      context,
                                                      Colors.black,
                                                      'You\'v deleted this message');
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: SingleMessage(
                                      message: snapshot.data!.docs[index]
                                          ['message'],
                                      isMe: isMe,
                                      time: time),
                                );
                              });
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                ),
              ),
              MessageTextField(widget.currentUser!.uid, widget.friendId!),
            ],
          ),
        ),
      ),
    );
  }
}
