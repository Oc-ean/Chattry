import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageTile extends StatefulWidget {
  final String message;
  final String sender;
  final bool isMe;
  final dynamic dataTime;
  final dynamic onLongTap;
  const MessageTile(
      {Key? key,
      required this.message,
      required this.dataTime,
      required this.sender,
      required this.isMe,
      required this.onLongTap})
      : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  final time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    // DateTime myTime = DateTime.parse(widget.dataTime);

    return Column(
      children: [
        Container(
          margin: widget.isMe
              ? EdgeInsets.only(
                  right: MediaQuery.of(context).size.width / 3,
                  left: 15.0,
                  top: 10,
                )
              : EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 3,
                  right: 15.0,
                  top: 12),
          alignment: widget.isMe ? Alignment.centerLeft : Alignment.centerRight,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: widget.isMe
                  ? const Color.fromRGBO(60, 80, 100, 1)
                  : Colors.blueAccent,
              elevation: 0.0,
              padding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: widget.isMe
                      ? const Radius.circular(0.0)
                      : const Radius.circular(20.0),
                  topRight: widget.isMe
                      ? const Radius.circular(20.0)
                      : const Radius.circular(0.0),
                  bottomLeft: const Radius.circular(20.0),
                  bottomRight: const Radius.circular(20.0),
                ),
              ),
            ),
            onPressed: () {},
            onLongPress: widget.onLongTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.sender.toUpperCase(),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -0.5),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 140,
                      child: Text(
                        widget.message,
                        maxLines: 50,
                        textAlign: TextAlign.start,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      DateFormat("jm").format(DateTime.parse(widget.dataTime)),
                      textAlign: TextAlign.start,
                      style: const TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
    // return Container(
    //   padding: EdgeInsets.only(
    //       top: 8,
    //       bottom: 4,
    //       left: widget.isMe ? 0 : 24,
    //       right: widget.isMe ? 24 : 0),
    //   alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
    //   child: Container(
    //     margin: widget.isMe
    //         ? const EdgeInsets.only(left: 30)
    //         : const EdgeInsets.only(right: 30),
    //     padding:
    //         const EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
    //     decoration: BoxDecoration(
    //         borderRadius: widget.isMe
    //             ? const BorderRadius.only(
    //                 topLeft: Radius.circular(20),
    //                 topRight: Radius.circular(20),
    //                 bottomLeft: Radius.circular(20),
    //               )
    //             : const BorderRadius.only(
    //                 topLeft: Radius.circular(20),
    //                 topRight: Radius.circular(20),
    //                 bottomRight: Radius.circular(20),
    //               ),
    //         color: widget.isMe
    //             ? Theme.of(context).primaryColor
    //             : Colors.grey[700]),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         Text(
    //           widget.sender.toUpperCase(),
    //           textAlign: TextAlign.start,
    //           style: const TextStyle(
    //               fontSize: 13,
    //               fontWeight: FontWeight.bold,
    //               color: Colors.white,
    //               letterSpacing: -0.5),
    //         ),
    //         const SizedBox(
    //           height: 8,
    //         ),
    //         Row(
    //           children: [
    //             Text(
    //               widget.message,
    //               maxLines: 50,
    //               textAlign: TextAlign.start,
    //               style: const TextStyle(fontSize: 16, color: Colors.white),
    //             ),
    //             SizedBox(
    //               width: 10,
    //             ),
    //             // Text(
    //             //   widget.dataTime,
    //             //   maxLines: 2,
    //             //   style: const TextStyle(color: Colors.red),
    //             //
    //             //   // formatDate(
    //             //   //   time,
    //             //   //   [M, ", ", d, " ", yyyy, " ", "at", " ", hh, ":", nn, " ", am],
    //             //   // ),
    //             // ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
