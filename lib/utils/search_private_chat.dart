import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/models/user_models.dart';
import 'package:simple_messaging_app/screens/private_chat.dart';

class SearchPrivateChat extends StatefulWidget {
  final dynamic user;
  const SearchPrivateChat({Key? key, this.user}) : super(key: key);

  @override
  State<SearchPrivateChat> createState() => _SearchPrivateChatState();
}

class _SearchPrivateChatState extends State<SearchPrivateChat> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult = [];
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;
  String email = '';
  String userName = '';

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
  }

  void onSearch() async {
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection('users')
        .where("name", isEqualTo: searchController.text)
        .get()
        .then((value) {
      // ignore: prefer_is_empty
      if (value.docs.length < 1) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("No User Found")));
        setState(() {
          isLoading = false;
        });
        return;
      }
      value.docs.forEach((user) {
        if (user.data()['email'] != currentUser.email) {
          searchResult.add(user.data());
        }
      });
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Search your Friend"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                        hintText: "type username....",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    onSearch();
                    searchController.clear();
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
          if (searchResult.length > 0)
            Expanded(
              child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Text(
                        searchResult[index]['name']
                            .substring(0, 1)
                            .toUpperCase(),
                        style:
                            const TextStyle(fontSize: 21, color: Colors.white),
                      ),
                    ),
                    title: Text(searchResult[index]['name']),
                    subtitle: Text(searchResult[index]['email']),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            searchController.text = "";
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PrivateChat(
                                        currentUser: currentUser,
                                        friendId: searchResult[index]['uid'],
                                        friendName: searchResult[index]['name'],
                                      )));
                          print(
                              ' User uid ========>${searchResult[index]['uid']}<=========');

                          print('What that======> ${currentUser}<======');
                        },
                        icon: const Icon(Icons.message)),
                  );
                },
              ),
            )
          else if (isLoading == true)
            const Center(
              child: CircularProgressIndicator(),
            )
        ],
      ),
    );
  }
}
