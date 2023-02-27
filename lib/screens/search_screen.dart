import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/screens/chat_screen.dart';
import 'package:simple_messaging_app/service/database.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/g_nav.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller = TextEditingController();
  bool _isLoading = false;
  QuerySnapshot? searchSnapshot;
  bool isJoined = false;
  bool hasUser = false;
  String userName = '';
  User? user;

  @override
  void initState() {
    getCurrentUserId();
    super.initState();
  }

  getCurrentUserId() async {
    await HelperFunctions.getUserNameFromSf().then((value) {
      setState(() {
        userName = value!;
      });
    });
    user = FirebaseAuth.instance.currentUser;
  }

  getName(String name) {
    return name.substring(name.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Search',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade300,
            ),

            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      border: InputBorder.none,
                      hintText: 'Search for groups',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      searchMethod();
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // child: Expanded(
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: TextField(
            //           controller: controller,
            //           style: const TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ),
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              : groupLists(),
        ],
      ),
    );
  }

  searchMethod() async {
    if (controller.text.isNotEmpty) {
      _isLoading = true;
      await DatabaseService().searchByName(controller.text).then((snapShot) {
        setState(() {
          searchSnapshot = snapShot;
          _isLoading = false;
          hasUser = true;
        });
      });
    }
  }

  groupLists() {
    return hasUser
        ? ListView.builder(
            itemCount: searchSnapshot!.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return groupTile(
                  userName,
                  searchSnapshot!.docs[index]['groupId'],
                  searchSnapshot!.docs[index]['groupName'],
                  searchSnapshot!.docs[index]['admin']);
            })
        : Container();
  }

  joinedOrNot(
      String userName, String groupId, String groupName, String admin) async {
    await DatabaseService(uid: user!.uid)
        .isUserJoined(groupName, groupId, userName)
        .then((value) {
      setState(() {
        isJoined = value;
      });
    });
  }

  groupTile(String userName, String groupId, String groupName, String admin) {
    /// to check if user are already present in the group....
    joinedOrNot(
      userName,
      groupId,
      groupName,
      admin,
    );
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
      // height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).primaryColor.withOpacity(0.6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
      child: ListTile(
        // contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Theme.of(context).primaryColor,
          child: Text(
            groupName.substring(0, 1).toUpperCase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ),
        title: Text(
          groupName,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text('Admin: ${getName(admin)} '),
        trailing: InkWell(
          onTap: () async {
            await DatabaseService(uid: user!.uid)
                .toggleGroupJoin(groupId, userName, groupName);
            if (isJoined) {
              setState(() {
                isJoined != isJoined;
              });
              showSnackBar(context, Colors.black,
                  'Successfully joined $groupName group');
              Future.delayed(const Duration(seconds: 3), () {
                nextScreen(
                    context,
                    ChatScreen(
                        groupName: groupName,
                        groupId: groupId,
                        currentUserName: userName));
              });
            } else {
              showSnackBar(context, Colors.red, 'Left the group $groupName');
            }
          },
          child: isJoined
              ? Container(
                  height: 40,
                  width: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    border: Border.all(color: Colors.white, width: 1),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: const Text(
                    'Joined',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : Container(
                  height: 40,
                  width: 90,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor,
                    // border: Border.all(color: Colors.indigoAccent.shade700),
                  ),
                  child: const Text(
                    'Join chat',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }
}
