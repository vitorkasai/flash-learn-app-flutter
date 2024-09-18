import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  void toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void _loadThemePreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _isDarkMode = sharedPreferences.getBool('isDarkMode') ?? false;
    notifyListeners();
  }
}
