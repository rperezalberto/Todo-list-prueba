import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/services/DBServices.dart';
import 'package:todo_list/theme/app_theme.dart';

class ThemeProvider with ChangeNotifier {
  final DBService dbService = DBService();
  ThemeData currentTheme = AppThemes.darkTheme;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  ThemeProvider() {
    _loadTheme();
  }

  void changeTheme() async {
    if (currentTheme == AppThemes.darkTheme) {
      currentTheme = AppThemes.lightTheme;
      await saveSetting('theme_mode', 'light');
    } else {
      currentTheme = AppThemes.darkTheme;
      await saveSetting('theme_mode', 'dark');
    }
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final themeMode = await getSetting('theme_mode');
    currentTheme =
        themeMode == 'light' ? AppThemes.lightTheme : AppThemes.darkTheme;

    _isLoaded = true;
    notifyListeners();
  }

  Future<void> saveSetting(String key, String value) async {
    final db = await dbService.database;
    await db.insert(
      'settings',
      {'key': key, 'value': value},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<String?> getSetting(String key) async {
    final db = await dbService.database;
    final result = await db.query(
      'settings',
      where: 'key = ?',
      whereArgs: [key],
      limit: 1,
    );
    if (result.isNotEmpty) return result.first['value'] as String;
    return null;
  }
}
