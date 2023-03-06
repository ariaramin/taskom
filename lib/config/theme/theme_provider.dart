import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskom/di/di.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences _preferences = locator.get();
  static const THEME_KEY = "theme_key";
  late bool _isDark;

  bool get isDark => _isDark;

  ThemeProvider() {
    getTheme();
  }

  set isDark(bool value) {
    _isDark = value;
    setTheme(value);
    notifyListeners();
  }

  setTheme(bool value) {
    _preferences.setBool(THEME_KEY, value);
  }

  getTheme() {
    _isDark = _preferences.getBool(THEME_KEY) ?? false;
    notifyListeners();
  }
}
