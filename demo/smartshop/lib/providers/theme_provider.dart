import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  static late SharedPreferences _prefs;
  bool _isDarkMode = false;

  ThemeProvider() {
    _isDarkMode = _prefs.getBool('isDarkMode') ?? false;
  }

  static Future<void> loadThemeFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }
}
