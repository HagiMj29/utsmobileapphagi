
import 'package:http/http.dart'as http;
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesHelper {
  static const String userIdKey = 'user_id';
  static const String userNameKey = 'user_name';
  static const String userEmailKey = 'user_email';


  static Future<void> saveUserProfile(Map<String, dynamic> user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(userIdKey, user['id']);
    prefs.setString(userNameKey, user['name']);
    prefs.setString(userEmailKey, user['email']);
  }

  static Future<int?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(userIdKey);
  }

  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userEmailKey);
  }

  static Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(userIdKey);
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userIdKey);
    prefs.remove(userNameKey);
    prefs.remove(userEmailKey);
  }


}
