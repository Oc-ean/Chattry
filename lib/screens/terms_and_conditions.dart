import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'About Chattry App',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "A Private, Secure, End-to-End Encrypted Messaging app that helps you to connect with your connections without any Ads, promotion. No other third party person, organization, or even Chattry App Team can't read your messages.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white70, fontSize: 16.0),
                ),
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.only(
            //       bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: Text(
            //       'Alert:  If you registered your mobile number and if any connection will call you, your number will visible in their call Logs.',
            //       textAlign: TextAlign.justify,
            //       style: TextStyle(color: Colors.redAccent, fontSize: 16.0),
            //     ),
            //   ),
            // ),
            const Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Messages are End-to-End Encrypted',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.amber, fontSize: 16.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 30.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Hope You Are Enjoying this app',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.lightBlue, fontSize: 18.0),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 50.0),
              child: Align(
                alignment: Alignment.centerRight,
                // child: Text(
                //   'Creator\nMicheal',
                //   textAlign: TextAlign.center,
                //   style: TextStyle(color: Colors.lightBlue, fontSize: 18.0),
                // ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: 70,
                color: Colors.red,
                child: const Center(
                    child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
