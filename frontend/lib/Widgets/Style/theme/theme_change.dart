import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier{
  static bool _isDark = false;
  ThemeMode currentTheme(){
    return !_isDark?ThemeMode.dark:ThemeMode.light;
  }
  void switchThemes(){
    _isDark = !_isDark;
    notifyListeners();
  }
}