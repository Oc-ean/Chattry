import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/screens/sign_in_screen.dart';
import 'package:simple_messaging_app/screens/terms_and_conditions.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          image: DecorationImage(
            image: AssetImage(
              'assets/3d.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      image: const DecorationImage(
                          image: AssetImage('assets/swipe.png'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: 40, color: Colors.white.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Chattry is an android social platform',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    'mobile messaging with friends',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white.withOpacity(0.8)),
                  ),
                  Text(
                    'all over the world',
                    style: TextStyle(
                        fontSize: 20, color: Colors.white.withOpacity(0.8)),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) =>
                              const TermsAndConditionsScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 45, vertical: 15),
                        child: Text(
                          'Terms and conditions',
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.8)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                              builder: (context) => const SignInScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.right_chevron,
                          color: Colors.white.withOpacity(0.8),
                        ),
                        Text(
                          'Let\'s Start',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
