import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/screens/group_screen.dart';
import 'package:simple_messaging_app/service/database.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/g_nav.dart';

class GroupInfoScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String adminName;
  const GroupInfoScreen(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.adminName})
      : super(key: key);

  @override
  State<GroupInfoScreen> createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  Stream? members;
  @override
  void initState() {
    getMembers();
    super.initState();
  }

  getMembers() async {
    DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getGroupMember(widget.groupId)
        .then((value) {
      setState(() {
        members = value;
      });
    });
  }

  getName(String name) {
    return name.substring(name.indexOf("_") + 1);
  }

  String getId(String id) {
    return id.substring(0, id.indexOf("_"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text("Group Info"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('Exit'),
                        content:
                            const Text('Are you sure want to exit the group?'),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                            style: ElevatedButton.styleFrom(
                                primary: Theme.of(context).primaryColor),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              DatabaseService(
                                      uid: FirebaseAuth
                                          .instance.currentUser!.uid)
                                  .toggleGroupJoin(
                                      widget.groupId,
                                      getName(widget.adminName),
                                      widget.groupName)
                                  .whenComplete(() {
                                nextScreenReplacement(
                                  context,
                                  const BottomNav(),
                                );
                              });
                            },
                            child: const Text('Yes'),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                          ),
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ]),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(
                      widget.groupName.substring(0, 1).toUpperCase(),
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Group name: ${widget.groupName}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Admin: ${getName(widget.adminName)}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            memberLists(),
          ],
        ),
      ),
    );
  }

  memberLists() {
    return StreamBuilder(
        stream: members,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['members'] != null) {
              if (snapshot.data['members'].length != 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['members'].length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        // height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.6),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 3),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Theme.of(context).primaryColor,
                            child: Text(
                              getName(snapshot.data['members'][index])
                                  .toString()
                                  .substring(0, 1)
                                  .toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                          title: Text(
                            getName(
                              snapshot.data['members'][index],
                            ),
                          ),
                          subtitle: Text(
                            getId(
                              snapshot.data['members'][index],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text("No members"),
                );
              }
            } else {
              return const Center(
                child: Text("No members"),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        });
  }
}
