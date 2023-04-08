import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskom/di/di.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();

  static void saveToken(String token) {
    _sharedPref.setString("access_token", token);
    authChangeNotifire.value = token;
  }

  static String getToken() {
    return _sharedPref.getString("access_token") ?? "";
  }

  static void saveUserId(String id) {
    _sharedPref.setString("user_id", id);
  }

  static String getUserId() {
    return _sharedPref.getString("user_id") ?? "";
  }

  static void logout() {
    _sharedPref.remove("access_token");
    authChangeNotifire.value = null;
  }

  static bool isLogedIn() {
    return getToken().isNotEmpty;
  }
}
