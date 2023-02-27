import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:simple_messaging_app/screens/group_screen.dart';
import 'package:simple_messaging_app/screens/group_screen.dart';
import 'package:simple_messaging_app/screens/private_chat_home_screen.dart';
import 'package:simple_messaging_app/screens/profile_screen.dart';
import 'package:simple_messaging_app/utils/global_friends.dart';
import 'package:simple_messaging_app/utils/search_private_chat.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int _currentIndex = 0;
  List pages = [
    PrivateChatHomeScreen(),
    GlobalFriends(),
    const GroupScreen(),
    const SearchPrivateChat(),
    ProfileScreen(),
    // ChatScreen(),
    // LogScreen(),
    // ActivityScreen(),
    // GeneralMessagingSection(),
    // Connect(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: WillPopScope(
        onWillPop: () async {
          if (_currentIndex > 0) {
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              // color: Colors.blueGrey.withOpacity(0.2),
            ),
            child: GNav(
              onTabChange: (index) {
                print('Index is : $index');
                if (mounted) {
                  setState(() {
                    _currentIndex = index;
                  });
                }
              },
              color: Colors.blueGrey,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.white54,
              padding: const EdgeInsets.all(16),
              gap: 8,
              tabs: const [
                GButton(
                    icon: CupertinoIcons.bubble_right_fill,
                    text: 'Chats',
                    iconColor: Colors.white),
                GButton(
                    icon: CupertinoIcons.phone,
                    text: 'Contact',
                    iconColor: Colors.white),
                GButton(
                    icon: Icons.group, text: 'Groups', iconColor: Colors.white),
                GButton(
                    icon: CupertinoIcons.search,
                    text: 'Search',
                    iconColor: Colors.white),
                GButton(
                    icon: Icons.person,
                    text: 'Profile',
                    iconColor: Colors.white),
              ],
            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          // backgroundColor: const Color(0xFF101D25),
          body: Column(
            children: [Expanded(child: pages[_currentIndex])],
          ),
        ),
      ),
    );
  }
//
// TabBar _bottom() {
//   return TabBar(
//     labelColor: Colors.white,
//     unselectedLabelColor: Colors.white60,
//     indicatorPadding: const EdgeInsets.only(
//       left: 20,
//       right: 20,
//     ),
//     indicator: const UnderlineTabIndicator(
//       borderSide: BorderSide(width: 2.0, color: Colors.lightBlue),
//       insets: EdgeInsets.symmetric(horizontal: 15),
//     ),
//     automaticIndicatorColorAdjustment: true,
//     labelStyle:
//         const TextStyle(fontWeight: FontWeight.w500, letterSpacing: 1.0),
//     onTap: (index) {
//       print('Index is : $index');
//       if (mounted) {
//         setState(() {
//           _currentIndex = index;
//         });
//       }
//     },
//     tabs: const [
//       Tab(
//         child: Text(
//           'Chats',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       Tab(
//         child: Text(
//           'Logs',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       Tab(
//         child: Text(
//           'Status',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//       Tab(
//         icon: Icon(
//           Icons.store,
//           size: 20,
//         ),
//       ),
//     ],
//   );
// }

// Widget _bottomNavigationBar() {
//   return Container(
//     margin: const EdgeInsets.only(left: 10, right: 10),
//     width: double.maxFinite,
//     height: 60.0,
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(23),
//       color: const Color(0xFF101D25),
//     ),
//     child: Row(
//       children: [
//         IconButton(
//           onPressed: () {},
//           icon: const Icon(
//             CupertinoIcons.paperclip,
//             color: Colors.grey,
//           ),
//         ),
//       ],
//     ),
//   );
// }
}
