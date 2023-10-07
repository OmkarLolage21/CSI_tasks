import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = ThemeData.dark();
  ThemeData get Theme => _theme;
  // final _isDark;

  void toggleTheme(_isDark) {
    // final _isDark = _theme == ThemeData.dark();
    if (_isDark) {
      _theme = ThemeData.light();
    } else {
      _theme = ThemeData.dark();
    }
    notifyListeners();
  }
}
