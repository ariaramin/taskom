import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskom/di/di.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharedPref = locator.get();
  static const String accessToken = "access_token";
  static const String userId = "user_id";

  static void saveToken(String token) {
    _sharedPref.setString(accessToken, token);
    authChangeNotifire.value = token;
  }

  static String getToken() {
    return _sharedPref.getString(accessToken) ?? "";
  }

  static void saveUserId(String id) {
    _sharedPref.setString(userId, id);
  }

  static String getUserId() {
    return _sharedPref.getString(userId) ?? "";
  }

  static void logout() {
    _sharedPref.remove(accessToken);
    _sharedPref.remove(userId);
    authChangeNotifire.value = null;
  }

  static bool isLogedIn() {
    return getToken().isNotEmpty;
  }
}
