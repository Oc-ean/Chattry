import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constant {
  static String apiKey = 'AIzaSyAru7Sc-fBBD58QWLguDznnq85GJQclA0Q';
  static String appId = '1:854943406934:web:f529a321e1605e270654f7';
  static String messagingSenderId = '854943406934';
  static String projectId = 'simply-messaging-app';
  final primaryColor = Colors.deepPurple.shade300;
  // final primaryColor = Colors.deepOrange.shade300;
}

void nextScreen(BuildContext context, page) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
}

void nextScreenReplacement(BuildContext context, page) {
  Navigator.pushReplacement(
      context, CupertinoPageRoute(builder: (context) => page));
}

void showSnackBar(BuildContext context, color, message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(fontSize: 14),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: 'Ok',
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}
