import 'package:flutter/material.dart';
import 'package:simple_messaging_app/screens/chat_screen.dart';
import 'package:simple_messaging_app/utils/const.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {Key? key,
      required this.userName,
      required this.groupId,
      required this.groupName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    print("ID =========> ${widget.groupId}");

    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatScreen(
              groupName: widget.groupName,
              groupId: widget.groupId,
              currentUserName: widget.userName,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 7, top: 10, left: 10, right: 10),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          color: const Color(0xFF8E7EC5).withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: const Color(0xFF8E7EC5),
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          subtitle: Text(
            "Join the conversation as ${widget.userName}",
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ),
    );
  }
}
