import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  const MessageTextField(
    this.currentId,
    this.friendId,
  );

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  final TextEditingController _controller = TextEditingController();
  bool _showEmoji = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(
            left: 0,
            right: 0,
            bottom: 0,
          ),
          width: double.maxFinite,
          // height: 56.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            color: const Color(0xFF3E3E3E),
            // color: const Color.fromRGBO(25, 39, 52, 1),
          ),
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xFF3E3E3E),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _showEmoji = !_showEmoji;
                        });
                      },
                      icon: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.indigoAccent,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 125,
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.visiblePassword,
                        maxLines: 10,
                        minLines: 1,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 0,
                            left: 7,
                          ),
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        controller: _controller,
                      ),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    InkWell(
                      child: const CircleAvatar(
                        child: Icon(Icons.send),
                        // child: writeTextPresented
                        //     ? const Icon(Icons.send)
                        //     : const Icon(Icons.keyboard_voice_rounded),
                      ),
                      onTap: () async {
                        if (_controller.text.isNotEmpty) {
                          String message = _controller.text;
                          _controller.clear();
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.currentId)
                              .collection('messages')
                              .doc(widget.friendId)
                              .collection('chats')
                              .add({
                            "senderId": widget.currentId,
                            "receiverId": widget.friendId,
                            "message": message,
                            "type": "text",
                            "date": DateTime.now(),
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.currentId)
                                .collection('messages')
                                .doc(widget.friendId)
                                .set({
                              'last_msg': message,
                              "date": DateTime.now()
                            });
                          });

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(widget.friendId)
                              .collection('messages')
                              .doc(widget.currentId)
                              .collection("chats")
                              .add({
                            "senderId": widget.currentId,
                            "receiverId": widget.friendId,
                            "message": message,
                            "type": "text",
                            "date": DateTime.now(),
                          }).then((value) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.friendId)
                                .collection('messages')
                                .doc(widget.currentId)
                                .set({
                              "last_msg": message,
                              "date": DateTime.now()
                            });
                          });
                        } else {
                          print("Can't add ");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// GestureDetector(
// onTap: () async {
// String message = _controller.text;
// _controller.clear();
// await FirebaseFirestore.instance
//     .collection('users')
// .doc(widget.currentId)
// .collection('messages')
// .doc(widget.friendId)
// .collection('chats')
// .add({
// "senderId": widget.currentId,
// "receiverId": widget.friendId,
// "message": message,
// "type": "text",
// "date": DateTime.now(),
// }).then((value) {
// FirebaseFirestore.instance
//     .collection('users')
//     .doc(widget.currentId)
//     .collection('messages')
//     .doc(widget.friendId)
//     .set({'last_msg': message, "date": DateTime.now()});
// });
//
// await FirebaseFirestore.instance
//     .collection('users')
// .doc(widget.friendId)
// .collection('messages')
// .doc(widget.currentId)
// .collection("chats")
// .add({
// "senderId": widget.currentId,
// "receiverId": widget.friendId,
// "message": message,
// "type": "text",
// "date": DateTime.now(),
// }).then((value) {
// FirebaseFirestore.instance
//     .collection('users')
//     .doc(widget.friendId)
//     .collection('messages')
//     .doc(widget.currentId)
//     .set({"last_msg": message, "date": DateTime.now()});
// });
// },
// child: Container(
// padding: const EdgeInsets.all(15),
// decoration: const BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.blue,
// ),
// child: const Center(
// child: Icon(
// Icons.send,
// color: Colors.white,
// ),
// ),
// ),
// )
