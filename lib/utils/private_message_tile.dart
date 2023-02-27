import 'package:flutter/material.dart';

class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final String time;

  const SingleMessage({
    required this.message,
    required this.isMe,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          margin: const EdgeInsets.all(4),
          constraints: const BoxConstraints(maxWidth: 200),
          decoration: BoxDecoration(
            color:
                isMe ? const Color.fromRGBO(60, 80, 100, 1) : Colors.blueAccent,
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 4),
                margin: const EdgeInsets.only(right: 4),
                child: Text(
                  time,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//     return Row(
//       mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
//       children: [
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           margin: const EdgeInsets.all(4),
//           constraints: const BoxConstraints(maxWidth: 200),
//           decoration: BoxDecoration(
//               color: isMe ? Colors.blue : Colors.black,
//               borderRadius: const BorderRadius.all(Radius.circular(12))),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Text(
//                 message,
//                 style: const TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               Container(
//                 padding: const EdgeInsets.only(top: 4),
//                 margin: const EdgeInsets.only(right: 4),
//                 child: Text(
//                   time,
//                   style: const TextStyle(
//                     fontSize: 8,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
