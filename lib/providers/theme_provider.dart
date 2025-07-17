import 'package:flutter/material.dart';
import 'package:todo_list/theme/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData currentTheme = AppThemes.darkTheme;

// Cambiar de tema
  void changeTheme() {
    currentTheme = currentTheme == AppThemes.darkTheme
        ? AppThemes.lightTheme
        : AppThemes.darkTheme;
    notifyListeners();
  }
}
