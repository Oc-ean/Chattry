import 'package:firebase_auth/firebase_auth.dart';
import 'package:simple_messaging_app/helper/helper_function.dart';
import 'package:simple_messaging_app/service/database.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  /// login function....
  Future logInWithEmailAndPassword(String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user!;
      if (user != null) {
        /// calling database services to update the user data....
        // await DatabaseService(uid: user.uid).savingUsersData(email, password);
        return true;
      }
    } on FirebaseException catch (e) {
      print('SignUp =======> $e');
      return e.message;
    }
  }

  /// signup function....
  Future signUpWithEmailAndPassword(
      String fullName, String email, String password) async {
    try {
      User user = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password))
          .user!;
      if (user != null) {
        /// calling database services to update the user data....
        await DatabaseService(uid: user.uid).savingUsersData(fullName, email);
        return true;
      }
    } on FirebaseException catch (e) {
      print('SignUp =======> $e');
      return e.message;
    }
  }

  /// signout function....

  Future signOut() async {
    try {
      await HelperFunctions.saveUserLoggedInStatus(false);
      await HelperFunctions.saveUserEmailSf('');
      await HelperFunctions.saveUserNameSf('');
      await firebaseAuth.signOut();
    } catch (e) {
      return null;
    }
  }
}
