import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/provider/providers.dart';
import 'package:simple_messaging_app/screens/private_chat.dart';
import 'package:simple_messaging_app/screens/profile_screen.dart';
import 'package:simple_messaging_app/screens/search_screen.dart';
import 'package:simple_messaging_app/screens/sign_in_screen.dart';
import 'package:simple_messaging_app/service/authentication_service.dart';
import 'package:simple_messaging_app/service/database.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/global_friends.dart';
import 'package:simple_messaging_app/utils/group_tile.dart';
import 'package:simple_messaging_app/utils/search_private_chat.dart';

class GroupScreen extends StatefulWidget {
  final User? user;
  const GroupScreen({Key? key, this.user}) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  String userName = '';
  String email = '';
  String groupName = '';

  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await HelperFunctions.getUserEmailFromSf().then((value) {
      setState(() {
        email = value!;
      });
    });
    await HelperFunctions.getUserNameFromSf().then((value) {
      setState(() {
        userName = value!;
      });
    });

    /// getting lists of snapshot in Stream...
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      setState(() {
        groups = snapshot;
      });
    });
  }

  String getId(String id) {
    return id.substring(0, id.indexOf("_"));
  }

  String getName(String name) {
    return name.substring(name.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        return Scaffold(
          // drawer: Drawer(
          //   child: ListView(
          //     padding: const EdgeInsets.symmetric(vertical: 50),
          //     children: [
          //       Icon(
          //         Icons.account_circle,
          //         size: 150,
          //         color: Colors.grey.shade700,
          //       ),
          //       const SizedBox(
          //         height: 10,
          //       ),
          //       Text(
          //         userName,
          //         textAlign: TextAlign.center,
          //         style: const TextStyle(
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       const SizedBox(
          //         height: 20,
          //       ),
          //       const Divider(
          //         height: 3,
          //       ),
          //       ListTile(
          //         onTap: () {},
          //         selectedColor: Theme.of(context).primaryColor,
          //         selected: true,
          //         contentPadding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //         leading: const Icon(Icons.group),
          //         title: const Text(
          //           'Groups',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //       ListTile(
          //         onTap: () {
          //           nextScreenReplacement(
          //             context,
          //             ProfileScreen(
          //               userName: userName,
          //               email: email,
          //             ),
          //           );
          //         },
          //         contentPadding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //         leading: const Icon(Icons.person),
          //         title: const Text(
          //           'Profile',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //       ListTile(
          //         onTap: () {
          //           nextScreenReplacement(
          //               context,
          //               // PrivateChat(),
          //               ProfileScreen(userName: userName, email: email));
          //         },
          //         contentPadding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //         leading: const Icon(CupertinoIcons.bubble_left_fill),
          //         title: const Text(
          //           'Messages',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //       ListTile(
          //         onTap: () {
          //           nextScreenReplacement(
          //             context,
          //             GlobalFriends(),
          //           );
          //         },
          //         contentPadding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //         leading: const Icon(Icons.group_add_sharp),
          //         title: const Text(
          //           'Contacts',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //       ListTile(
          //         onTap: () {
          //           nextScreenReplacement(
          //             context,
          //             SearchPrivateChat(),
          //           );
          //         },
          //         contentPadding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //         leading: const Icon(CupertinoIcons.chevron_compact_up),
          //         title: const Text(
          //           'Main',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //       ListTile(
          //         onTap: () {
          //           _isLoading
          //               ? Center(
          //                   child: CircularProgressIndicator(
          //                     color: Theme.of(context).primaryColor,
          //                   ),
          //                 )
          //               : showDialog(
          //                   barrierDismissible: false,
          //                   context: context,
          //                   builder: (_) {
          //                     return AlertDialog(
          //                       title: const Text('Log out'),
          //                       content:
          //                           const Text('Are you sure want to log out'),
          //                       actions: [
          //                         // IconButton(
          //                         //   onPressed: () {
          //                         //     Navigator.pop(context);
          //                         //   },
          //                         //   icon: const Icon(
          //                         //     Icons.cancel,
          //                         //     color: Colors.red,
          //                         //   ),
          //                         // ),
          //                         ElevatedButton(
          //                           onPressed: () {
          //                             Navigator.pop(context);
          //                           },
          //                           child: const Text('NO'),
          //                           style: ElevatedButton.styleFrom(
          //                               primary:
          //                                   Theme.of(context).primaryColor),
          //                         ),
          //                         ElevatedButton(
          //                           onPressed: () {
          //                             dataProvider.signOut(context);
          //                           },
          //                           child: const Text('yes'),
          //                           style: ElevatedButton.styleFrom(
          //                               primary: Colors.red),
          //                         ),
          //                         // IconButton(
          //                         //   onPressed: () {
          //                         //     authService.signOut();
          //                         //     Navigator.pushAndRemoveUntil(
          //                         //         context,
          //                         //         MaterialPageRoute(
          //                         //             builder: (context) =>
          //                         //                 const SignInScreen()),
          //                         //         (route) => false);
          //                         //   },
          //                         //   icon: const Icon(
          //                         //     Icons.done,
          //                         //     color: Colors.green,
          //                         //   ),
          //                         // ),
          //                       ],
          //                     );
          //                   });
          //         },
          //         contentPadding:
          //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //         leading: const Icon(Icons.exit_to_app),
          //         title: const Text(
          //           'LogOut',
          //           style: TextStyle(color: Colors.black),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF8E7EC5),
            actions: [
              IconButton(
                onPressed: () {
                  nextScreen(context, const SearchScreen());
                },
                icon: const Icon(Icons.search),
              ),
            ],
            title: const Text(
              'Groups',
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF8E7EC5),
            onPressed: () {
              popUpDialog(context);
              // showDialog(context: context, builder: (_) => PopUpDialog(context));
            },
            child: const Icon(
              Icons.add,
              size: 32,
            ),
          ),
          body: groupsLists(context),
          //     body: Center(
          //   child: ElevatedButton(
          //     child: const Text('Logout'),
          //     onPressed: () {
          //       authService.signOut();
          //     },
          //   ),
          // ),
        );
      },
    );
  }

  popUpDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: const Text(
                  'Create a group',
                  textAlign: TextAlign.left,
                ),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _isLoading == true
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          )
                        : TextField(
                            keyboardType: TextInputType.visiblePassword,
                            onChanged: (val) {
                              setState(() {
                                groupName = val;
                              });
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                  ],
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (groupName != "") {
                          setState(() {
                            _isLoading = true;
                          });
                          DatabaseService(
                                  uid: FirebaseAuth.instance.currentUser!.uid)
                              .createGroups(
                                  userName,
                                  FirebaseAuth.instance.currentUser!.uid,
                                  groupName)
                              .whenComplete(() => _isLoading = false);
                          Navigator.pop(context);
                          showSnackBar(context, Colors.green,
                              'Group created successfully');
                        }
                      },
                      child: const Text('Create'),
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        });
  }

  groupsLists(BuildContext context) {
    return StreamBuilder(
        stream: groups,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['group'] != null) {
              if (snapshot.data['group'].length != 0) {
                return ListView.builder(
                  itemCount: snapshot.data['group'].length,
                  itemBuilder: (context, index) {
                    int reversedIndex =
                        snapshot.data['group'].length - index - 1;
                    return GroupTile(
                        // lastMsg: snapshot.data.['message'],
                        userName: snapshot.data["name"],
                        groupId: getId(snapshot.data['group'][reversedIndex]),
                        groupName:
                            getName(snapshot.data['group'][reversedIndex]));
                  },
                );
              } else {
                return noGroupWidget();
              }
            }
            return noGroupWidget();
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          }
        });
  }

  noGroupWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // InkWell(
          //   onTap: () {
          //     popUpDialog(context);
          //   },
          //   child: Icon(
          //     Icons.add_circle,
          //     color: Colors.grey.shade700,
          //     size: 75,
          //   ),

          const SizedBox(
            height: 20,
          ),
          const Text(
            "You 've not joined any groups, tap on the add icon to create a group or also click from the top search button.",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
