import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:simple_messaging_app/screens/private_chat.dart';

class PrivateChatHomeScreen extends StatefulWidget {
  final User? user;
  const PrivateChatHomeScreen({Key? key, this.user}) : super(key: key);

  @override
  State<PrivateChatHomeScreen> createState() => _PrivateChatHomeScreenState();
}

class _PrivateChatHomeScreenState extends State<PrivateChatHomeScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(currentUser.uid)
              .collection('messages')
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length < 1) {
                return const Center(
                  child: Text("No Chats Available !"),
                );
              }
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    var friendId = snapshot.data.docs[index].id;
                    var lastMsg = snapshot.data.docs[index]['last_msg'];

                    // var date = snapshot.data.docs[index]['date'];
                    var a = DateTime.parse(
                        snapshot.data.docs[index]['date'].toDate().toString());
                    var time = DateFormat(' hh:mm a').format(a);

                    return FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .get(),
                      builder: (context, AsyncSnapshot asyncSnapshot) {
                        if (asyncSnapshot.hasData) {
                          var friend = asyncSnapshot.data;
                          return ListTile(
                            leading: FloatingActionButton(
                              backgroundColor: Theme.of(context).primaryColor,
                              onPressed: () {},
                              child: Text(
                                friend['name']
                                    .toString()
                                    .substring(0, 1)
                                    .toUpperCase(),
                                style: const TextStyle(fontSize: 20),
                              ),
                              // leading: CircleAvatar(
                              //   radius: 30,
                              //   child: Text(
                              //     friend['name']
                              //         .toString()
                              //         .substring(0, 1)
                              //         .toUpperCase(),
                              //     style: TextStyle(fontSize: 16),
                              //   ),
                              // Text(asyncSnapshot.data.docs[index]['name']),
                              // backgroundImage: NetworkImage(friend['image']),
                            ),
                            title: Text(
                              friend['name'],
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            // ignore: avoid_unnecessary_containers
                            subtitle: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "$lastMsg",
                                    style: const TextStyle(color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    time,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrivateChat(
                                            currentUser: currentUser,
                                            friendId: friend['uid'],
                                            friendName: friend['name'],
                                          )));
                            },
                          );
                        }
                        return const LinearProgressIndicator();
                      },
                    );
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
