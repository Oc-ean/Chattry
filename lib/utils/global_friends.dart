import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/screens/private_chat.dart';

class GlobalFriends extends StatefulWidget {
  final User? user;
  GlobalFriends({this.user});

  @override
  State<GlobalFriends> createState() => _GlobalFriendsState();
}

class _GlobalFriendsState extends State<GlobalFriends> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Contacts',
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('email', isNotEqualTo: currentUser.email)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
            if (snapshots.hasData) {
              if (snapshots.data!.docs.length < 1) {
                return const Center(
                  child: Text("No Contacts Available !"),
                );
              }

              return (snapshots.connectionState == ConnectionState.waiting)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                              itemCount: snapshots.data!.docs.length,
                              itemBuilder: (context, index) {
                                var data = snapshots.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                return ListTile(
                                  title: Text(
                                    data['name'],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 28,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Text(
                                      data['name'].toString().substring(0, 1),
                                      style: const TextStyle(
                                          fontSize: 21, color: Colors.white),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PrivateChat(
                                            currentUser: currentUser,
                                            friendId:
                                                snapshots.data!.docs[index].id,
                                            friendName: snapshots
                                                .data!.docs[index]['name'],
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      CupertinoIcons
                                          .bolt_horizontal_circle_fill,
                                      size: 30,
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
