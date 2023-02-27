import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/provider/providers.dart';
import 'package:simple_messaging_app/screens/welcome_screen.dart';
import 'package:simple_messaging_app/screens/group_screen.dart';
import 'package:simple_messaging_app/screens/sign_in_screen.dart';
import 'package:simple_messaging_app/service/authentication_service.dart';
import 'package:simple_messaging_app/utils/const.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthService authService = AuthService();
  final bool _isLoading = false;
  String userName = '';
  String email = '';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gettingUserData();
  }

  /// getting lists of snapshot in Stream...
  // await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
  //     .getUserGroups()
  //     .then((snapshot) {
  //   setState(() {
  //     groups = snapshot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //   child: ListView(
      //     padding: const EdgeInsets.symmetric(vertical: 50),
      //     children: [
      //       const Icon(
      //         Icons.account_circle,
      //         size: 150,
      //         color: Colors.grey,
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       Text(
      //         widget.userName,
      //         textAlign: TextAlign.center,
      //         style: const TextStyle(
      //           fontWeight: FontWeight.w500,
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 30,
      //       ),
      //       const Divider(
      //         height: 2,
      //       ),
      //       ListTile(
      //         onTap: () {
      //           nextScreen(context, const HomeScreen());
      //         },
      //         contentPadding:
      //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //         leading: const Icon(Icons.group),
      //         title: const Text(
      //           'Groups',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       ),
      //       ListTile(
      //         selected: true,
      //         selectedColor: Theme.of(context).primaryColor,
      //         onTap: () {
      //           nextScreen(
      //             context,
      //             const HomeScreen(),
      //           );
      //         },
      //         contentPadding:
      //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //         leading: const Icon(Icons.group),
      //         title: const Text(
      //           'Profile',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           // nextScreenReplacement(
      //           //   context,
      //           //   ProfileScreen(
      //           //     // userName: userName,
      //           //     // email: email,
      //           //   ),
      //           // );
      //         },
      //         contentPadding:
      //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //         leading: const Icon(Icons.group),
      //         title: const Text(
      //           'Messages',
      //           style: TextStyle(color: Colors.black),
      //         ),
      //       ),
      //       ListTile(
      //         onTap: () {
      //           // nextScreenReplacement(
      //           //   context,
      //           //   ProfileScreen(
      //           //     userName: userName,
      //           //     email: email,
      //           //   ),
      //           // );
      //         },
      //         contentPadding:
      //             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //         leading: const Icon(Icons.group),
      //         title: const Text(
      //           'Contacts',
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
      //                               primary: Theme.of(context).primaryColor),
      //                         ),
      //                         ElevatedButton(
      //                           onPressed: () {
      //                             authService.signOut();
      //                             Navigator.pushAndRemoveUntil(
      //                                 context,
      //                                 MaterialPageRoute(
      //                                     builder: (context) =>
      //                                         const SignInScreen()),
      //                                 (route) => false);
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
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.maxFinite,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        padding: const EdgeInsets.symmetric(vertical: 33),
        child: Column(
          children: [
            Icon(
              Icons.account_circle,
              size: 200,
              color: Colors.grey.shade700,
            ),

            // CircleAvatar(
            //   radius: 95,
            //   backgroundColor: Theme.of(context).primaryColor,
            //   child: Text(
            //     userName.toString().substring(0, 1),
            //     style: const TextStyle(fontSize: 100, color: Colors.white),
            //   ),
            // ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              // height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'FullName',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 20,
              thickness: 2,
              color: Colors.black,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 20),
              // height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Theme.of(context).primaryColor.withOpacity(0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Email',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () {
                authService.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WelcomeScreen()),
                    (route) => false);
              },
              child: const Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
