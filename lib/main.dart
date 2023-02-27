import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/provider/providers.dart';
import 'package:simple_messaging_app/screens/welcome_screen.dart';

import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/g_nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    /// run initialization for web
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constant.apiKey,
        appId: Constant.appId,
        messagingSenderId: Constant.messagingSenderId,
        projectId: Constant.projectId,
      ),
    );
  } else {
    /// run initialization for mobile
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    getUserLoggedInStatus();
    super.initState();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DataProvider>(
          create: (context) => DataProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(primaryColor: Constant().primaryColor),
        home: _isSignedIn ? const BottomNav() : const WelcomeScreen(),
      ),
    );
  }
}
