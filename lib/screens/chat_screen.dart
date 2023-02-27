import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/screens/group_info_screen.dart';
import 'package:simple_messaging_app/service/database.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/message_tile.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatScreen extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String currentUserName;
  const ChatScreen(
      {Key? key,
      required this.groupName,
      required this.groupId,
      required this.currentUserName})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _editingController = TextEditingController();
  Stream<QuerySnapshot>? chats;
  String admin = ' ';
  // Message replyMessage;

  @override
  void initState() {
    getChatAndAdmin();
    super.initState();
  }

  getChatAndAdmin() async {
    DatabaseService().getChat(widget.groupId).then((value) {
      setState(() {
        chats = value;
      });
    });
    DatabaseService().getGroupAdmin(widget.groupId).then((value) {
      setState(() {
        admin = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.groupName),
        backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: const Color(0xFF3E3E3E),
        actions: [
          IconButton(
            onPressed: () {
              nextScreen(
                context,
                GroupInfoScreen(
                  groupName: widget.groupName,
                  groupId: widget.groupId,
                  adminName: admin,
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/app.png'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              Flexible(
                child: SizedBox(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  child: chatMessages(),
                ),
              ),

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
                            onPressed: () {},
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

                                // suffixIcon: Container(
                                //   child: Row(
                                //     mainAxisSize: MainAxisSize.min,
                                //     // mainAxisAlignment: MainAxisAlignment.end,
                                //     children: [
                                //       SizedBox(
                                //         width: 25,
                                //       ),
                                //       IconButton(
                                //         onPressed: () {
                                //           // showModalBottomSheet(
                                //           //     backgroundColor: Colors.transparent,
                                //           //     context: context,
                                //           //     builder: (builder) => BottomSheet());
                                //         },
                                //         icon: const Icon(
                                //           Icons.attach_file,
                                //           color: Colors.indigoAccent,
                                //         ),
                                //       ),
                                //       // SizedBox(
                                //       //   width: 10,
                                //       // ),
                                //       InkWell(
                                //         onTap: () async {
                                //           //   if (mounted) {
                                //           //     setState(() {
                                //           //       isLoading = true;
                                //           //     });
                                //           //   }
                                //           //   final pickerImage = await ImagePicker()
                                //           //       .pickImage(
                                //           //       source: ImageSource.camera,
                                //           //       imageQuality: 50);
                                //           //   if (pickerImage != null) {
                                //           //     _addSelectedMediaToChat(pickerImage.path);
                                //           //   }
                                //           //   if (mounted) {
                                //           //     setState(() {
                                //           //       isLoading = false;
                                //           //     });
                                //           //   }
                                //           // },
                                //           // onLongPress: () async {
                                //           //   if (mounted) {
                                //           //     setState(() {
                                //           //       isLoading = true;
                                //           //     });
                                //           //   }
                                //           //   final XFile? pickerImage =
                                //           //   await ImagePicker().pickVideo(
                                //           //     source: ImageSource.camera,
                                //           //     maxDuration: Duration(seconds: 15),
                                //           //   );
                                //           //   if (pickerImage != null) {
                                //           //     _addSelectedMediaToChat(pickerImage.path);
                                //           //   }
                                //           //   if (mounted) {
                                //           //     setState(() {
                                //           //       isLoading = false;
                                //           //     });
                                //           //   }
                                //           // final XFile? pickedImage = await ImagePicker()
                                //           //     .pickImage(source: ImageSource.gallery);
                                //           // if (pickedImage != null) {
                                //           //   _addSelectedMediaToChat(pickedImage.path);
                                //         },
                                //         child: const Icon(
                                //           Icons.camera_alt,
                                //           color: Colors.indigoAccent,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ),
                              controller: _editingController,
                              // onChanged: (writeText) {
                              //   if (writeText.isEmpty) {
                              //     isEmpty = true;
                              //   } else {
                              //     isEmpty = false;
                              //   }
                              //   if (mounted) {
                              //     setState(() {
                              //       writeTextPresented = !isEmpty;
                              //     });
                              //   }
                              // },
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
                            onTap: () {
                              sendMessage();
                              // if (writeTextPresented) {
                              //   final String _messageTime =
                              //       '${DateTime.now().hour} :${DateTime.now().minute}';
                              //   if (mounted) {
                              //     setState(() {
                              //       _allConversationMessage
                              //           .add({_typedText.text: _messageTime});
                              //       _chatMessageCategoryHolder.add(ChatMessageTypes.text);
                              //       _conversationMessageHolder.add(_lastDirection);
                              //       _lastDirection = !_lastDirection;
                              //       _typedText.clear();
                              //     });
                              //   }
                              //   if (mounted) {
                              //     setState(() {
                              //       isEmpty = false;
                              //     });
                              //   }
                              // }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Flexible(
              //   child: SizedBox(
              //     width: double.maxFinite,
              //     height: double.maxFinite,
              //     child: chatMessages(),
              //   ),
              // ),

              // Container(
              //   alignment: Alignment.bottomCenter,
              //   width: MediaQuery.of(context).size.width,
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              //     width: MediaQuery.of(context).size.width,
              //     color: Colors.grey.shade700,
              //     child: Row(
              //       children: [
              //         Expanded(
              //           child: TextFormField(
              //             controller: _editingController,
              //             maxLines: 5,
              //             style: const TextStyle(color: Colors.white),
              //             decoration: InputDecoration(
              //               hintText: 'Type a message...',
              //               hintStyle: TextStyle(
              //                   color: Colors.grey.shade200, fontSize: 15),
              //               border: InputBorder.none,
              //             ),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         InkWell(
              //           onTap: () {
              //             sendMessage();
              //           },
              //           child: Container(
              //             width: 65,
              //             height: 35,
              //             // margin: EdgeInsets.only(right: 10),
              //             decoration: BoxDecoration(
              //               color: Colors.blue,
              //               borderRadius: BorderRadius.circular(5),
              //             ),
              //             child: const Icon(
              //               Icons.send,
              //               color: Colors.white,
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  // bottomNavigationBar() {
  //   return Container(
  //     margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0),
  //     width: double.maxFinite,
  //     // height: 53.0,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(1),
  //       color: Colors.grey.shade700,
  //       // color: const Color.fromRGBO(25, 39, 52, 1),
  //     ),
  //     child: Stack(
  //       children: [
  //         Container(
  //           // margin: const EdgeInsets.only(
  //           //   left: 5,
  //           //   right: 5,
  //           width: double.maxFinite,
  //           // height: 55.0,
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30),
  //             color: Colors.grey.shade700,
  //           ),
  //           child: Row(
  //             children: [
  //               SizedBox(
  //                 width: MediaQuery.of(context).size.width - 90,
  //                 child: TextField(
  //                   style: const TextStyle(color: Colors.white),
  //                   textAlignVertical: TextAlignVertical.center,
  //                   keyboardType: TextInputType.visiblePassword,
  //                   maxLines: 5,
  //                   minLines: 1,
  //                   decoration: InputDecoration(
  //                     border: InputBorder.none,
  //                     contentPadding: const EdgeInsets.only(
  //                       top: 0,
  //                       left: 0,
  //                     ),
  //                     hintText: 'Type a message',
  //                     hintStyle: const TextStyle(color: Colors.grey),
  //                     prefixIcon: IconButton(
  //                       onPressed: () {},
  //                       icon: const Icon(
  //                         Icons.emoji_emotions,
  //                         color: Colors.indigoAccent,
  //                       ),
  //                     ),
  //                     suffixIcon: Container(
  //                       child: Row(
  //                         mainAxisSize: MainAxisSize.min,
  //                         // mainAxisAlignment: MainAxisAlignment.end,
  //                         children: [
  //                           const SizedBox(
  //                             width: 25,
  //                           ),
  //                           IconButton(
  //                             onPressed: () {
  //                               // showModalBottomSheet(
  //                               //     backgroundColor: Colors.transparent,
  //                               //     context: context,
  //                               //     builder: (builder) => BottomSheet());
  //                             },
  //                             icon: const Icon(
  //                               Icons.attach_file,
  //                               color: Colors.indigoAccent,
  //                             ),
  //                           ),
  //                           // SizedBox(
  //                           //   width: 10,
  //                           // ),
  //                           InkWell(
  //                             onTap: () async {
  //                               //   if (mounted) {
  //                               //     setState(() {
  //                               //       isLoading = true;
  //                               //     });
  //                               //   }
  //                               //   final pickerImage = await ImagePicker()
  //                               //       .pickImage(
  //                               //       source: ImageSource.camera,
  //                               //       imageQuality: 50);
  //                               //   if (pickerImage != null) {
  //                               //     _addSelectedMediaToChat(pickerImage.path);
  //                               //   }
  //                               //   if (mounted) {
  //                               //     setState(() {
  //                               //       isLoading = false;
  //                               //     });
  //                               //   }
  //                               // },
  //                               // onLongPress: () async {
  //                               //   if (mounted) {
  //                               //     setState(() {
  //                               //       isLoading = true;
  //                               //     });
  //                               //   }
  //                               //   final XFile? pickerImage =
  //                               //   await ImagePicker().pickVideo(
  //                               //     source: ImageSource.camera,
  //                               //     maxDuration: Duration(seconds: 15),
  //                               //   );
  //                               //   if (pickerImage != null) {
  //                               //     _addSelectedMediaToChat(pickerImage.path);
  //                               //   }
  //                               //   if (mounted) {
  //                               //     setState(() {
  //                               //       isLoading = false;
  //                               //     });
  //                               //   }
  //                               // final XFile? pickedImage = await ImagePicker()
  //                               //     .pickImage(source: ImageSource.gallery);
  //                               // if (pickedImage != null) {
  //                               //   _addSelectedMediaToChat(pickedImage.path);
  //                             },
  //                             child: const Icon(
  //                               Icons.camera_alt,
  //                               color: Colors.indigoAccent,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ),
  //                   controller: _editingController,
  //                   // onChanged: (writeText) {
  //                   //   if (writeText.isEmpty) {
  //                   //     isEmpty = true;
  //                   //   } else {
  //                   //     isEmpty = false;
  //                   //   }
  //                   //   if (mounted) {
  //                   //     setState(() {
  //                   //       writeTextPresented = !isEmpty;
  //                   //     });
  //                   //   }
  //                   // },
  //                 ),
  //               ),
  //               const SizedBox(
  //                 width: 35,
  //               ),
  //               InkWell(
  //                 child: const CircleAvatar(
  //                   child: Icon(Icons.send),
  //                   // child: writeTextPresented
  //                   //     ? const Icon(Icons.send)
  //                   //     : const Icon(Icons.keyboard_voice_rounded),
  //                 ),
  //                 onTap: () {
  //                   sendMessage();
  //                   // if (writeTextPresented) {
  //                   //   final String _messageTime =
  //                   //       '${DateTime.now().hour} :${DateTime.now().minute}';
  //                   //   if (mounted) {
  //                   //     setState(() {
  //                   //       _allConversationMessage
  //                   //           .add({_typedText.text: _messageTime});
  //                   //       _chatMessageCategoryHolder.add(ChatMessageTypes.text);
  //                   //       _conversationMessageHolder.add(_lastDirection);
  //                   //       _lastDirection = !_lastDirection;
  //                   //       _typedText.clear();
  //                   //     });
  //                   //   }
  //                   //   if (mounted) {
  //                   //     setState(() {
  //                   //       isEmpty = false;
  //                   //     });
  //                   //   }
  //                   // }
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  chatMessages() {
    // return StreamBuilder(
    //     stream: chats,
    //     builder: (context, AsyncSnapshot snapshot) {
    //       return snapshot.hasData
    //           ? ListView.builder(
    //               itemCount: snapshot.data.docs.length,
    //               itemBuilder: (context, index) {
    //                 return MessageTile(
    //                     message: snapshot.data.docs[index]['message'],
    //                     sender: snapshot.data.docs[index]['sender'],
    //                     isMe: widget.currentUserName ==
    //                         snapshot.data.docs[index]['sender']);
    //               },
    //             )
    //           : Container(
    //               height: 400,
    //               width: 500,
    //               child: const Text('Hello'),
    //               color: Colors.red,
    //             );
    //     });
    return StreamBuilder(
      stream: chats,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  return SwipeTo(
                    iconColor: Colors.white,
                    onRightSwipe: () => print('Me'),
                    child: MessageTile(
                      onLongTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                // insetPadding: const EdgeInsets.all(10),
                                backgroundColor: Theme.of(context).primaryColor,
                                title: const Text(
                                  'Delete message',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                content: const Text(
                                  'Are you sure you want to delete this message?',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                          color: Colors.indigo, fontSize: 20),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      DatabaseService().deleteMessage(
                                                groupId: widget.groupId,
                                                messageId: snapshot
                                                    .data!.docs[index].id,
                                              ) ==
                                              true
                                          ? Container(
                                              height: 30,
                                              width: 80,
                                              child: Text(
                                                  "You've deleted this message"),
                                            )
                                          : const Center(
                                              child: Text('Error'),
                                            );
                                      print('successful');
                                      Container(
                                        height: 30,
                                        width: 80,
                                        color: Colors.indigo,
                                        child: const Text(
                                            'You deleted this message'),
                                      );
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                    ),
                                  ),
                                ],
                              );
                            });
                        print('tapped');
                      },
                      message: snapshot.data!.docs[index]['message'],
                      sender: snapshot.data!.docs[index]['sender'],
                      isMe: widget.currentUserName ==
                          snapshot.data!.docs[index]['sender'],
                      dataTime: snapshot.data!.docs[index]['time'].toString(),
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  sendMessage() {
    if (_editingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": _editingController.text,
        "sender": widget.currentUserName,
        "time": DateTime.now().toIso8601String(),
        "timeStamp": Timestamp.now(),
        // 'time': formatDate(
        //   time,
        //   [M, ", ", d, " ", yyyy, " ", "at", " ", hh, ":", nn, " ", am],
        // ),
      };
      DatabaseService().sendMessage(widget.groupId, chatMessageMap);
      setState(() {
        _editingController.clear();
      });
    }
  }
}
