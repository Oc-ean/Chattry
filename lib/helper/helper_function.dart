import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  /// keys
  static String userLoggedInKey = 'LoggedInKey';
  static String userNameKey = 'UserNameKey';
  static String userEmailKey = 'UserEmailKey';

  /// saving the data to shared pref..
  static Future<bool> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserNameSf(String userName) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userNameKey, userName);
  }

  static Future<bool> saveUserEmailSf(String userEmail) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(userEmailKey, userEmail);
  }

  /// getting the data from shared pref..
  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(userLoggedInKey);
  }

  /// getting user data from shared pref...
  static Future<String?> getUserEmailFromSf() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userEmailKey);
  }

  static Future<String?> getUserNameFromSf() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(userNameKey);
  }
}
