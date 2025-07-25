import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  static late SharedPreferences _prefs;
  bool _isLoggedIn = false;

  AuthProvider();

  static Future<void> loadLoginStatus() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> login(String username, String password) async {
    // Updated login: username "admin", password "admin123"
    if (username == 'admin' && password == 'admin123') {
      _isLoggedIn = true;
      await _prefs.setBool('isLoggedIn', true);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    await _prefs.setBool('isLoggedIn', false);
    notifyListeners();
  }

  void checkLoginStatus() {
    _isLoggedIn = _prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }
}


