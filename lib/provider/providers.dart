import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/screens/group_screen.dart';
import 'package:simple_messaging_app/screens/sign_in_screen.dart';
import 'package:simple_messaging_app/service/authentication_service.dart';
import 'package:simple_messaging_app/service/database.dart';
import 'package:simple_messaging_app/utils/const.dart';
import 'package:simple_messaging_app/utils/g_nav.dart';

class DataProvider extends ChangeNotifier {
  AuthService authService = AuthService();
  TextEditingController signInEmailController = TextEditingController();
  TextEditingController signInPasswordController = TextEditingController();
  TextEditingController signUpEmailController = TextEditingController();
  TextEditingController signUpPasswordController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  final bool obscureText = false;

  bool isLoading = false;

  // final formKey = GlobalKey<FormState>();

  /// sign in....
  signIn(
    BuildContext context,
    dynamic formKey,
  ) async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      notifyListeners();
      await authService
          .logInWithEmailAndPassword(signInEmailController.text.trim(),
              signInPasswordController.text.trim())
          .then((value) async {
        if (value == true) {
          /// saving the shared preferences state
          QuerySnapshot snapshot =
              await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(signInEmailController.text.trim());

          /// saving the value to shared preferences....
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSf(
              signInEmailController.text.trim());
          await HelperFunctions.saveUserNameSf(snapshot.docs[0]['name']);
          signInEmailController.clear();
          signInPasswordController.clear();
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                    title: const Text('Welcome Back!'),
                    content: const Text('Sign in successful'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNav()),
                                (route) => false);
                          },
                          child: const Text('Okay'))
                    ],
                  ));

          // nextScreen(context, const HomeScreen());
        } else {
          showSnackBar(context, Colors.red, value);
          isLoading = false;
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }

  /// sign out...
  signOut(BuildContext context) {
    authService.signOut();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
        (route) => false);
    showSnackBar(context, Colors.black, 'Successfully logged out');
    notifyListeners();
  }

  /// sign up....
  signUp(BuildContext context, dynamic formKey1) async {
    if (formKey1.currentState!.validate()) {
      isLoading = true;
      notifyListeners();

      await authService
          .signUpWithEmailAndPassword(
              fullNameController.text.trim(),
              signUpEmailController.text.trim(),
              signUpPasswordController.text.trim())
          .then((value) async {
        if (value == true) {
          /// saving the shared preferences state
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSf(
              signUpEmailController.text.trim());
          await HelperFunctions.saveUserNameSf(fullNameController.text.trim());
          signUpEmailController.clear();
          signUpPasswordController.clear();
          fullNameController.clear();
          await showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => AlertDialog(
                    title: const Text('Sign up succeeded'),
                    content: const Text(
                        'Your account was created, you can now log in'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            nextScreen(
                              context,
                              const BottomNav(),
                            );
                          },
                          child: const Text('Okay'))
                    ],
                  ));
        } else {
          showSnackBar(context, Colors.red, value);
          isLoading = false;
          notifyListeners();
        }
      });
    }
    notifyListeners();
  }

  gettingUserData(String userName, [String email = '']) async {
    await HelperFunctions.getUserEmailFromSf().then((value) {
      email = value!;
      notifyListeners();
    });
    await HelperFunctions.getUserNameFromSf().then((value) {
      userName = value!;
      notifyListeners();
    });
  }
}
