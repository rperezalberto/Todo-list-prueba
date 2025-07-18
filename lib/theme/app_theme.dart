import 'package:flutter/material.dart';
import 'package:todo_list/theme/app_color.dart';

class AppThemes {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.color0xFF181818,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.color0xFF181818,
      titleTextStyle: TextStyle(
        color: AppColor.color0xFFFFFFFF,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.color0xFFBA83DE,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.color0xFF4F4F4F.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), //
        borderSide: BorderSide(
          color: AppColor.color0xFF4F4F4F.withOpacity(0.3),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), //
        borderSide: BorderSide(
          color: AppColor.color0xFF4F4F4F.withOpacity(0.3),
          width: 1,
        ),
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.color0xFFBA83DE,
      onPrimary: AppColor.color0xFFFFFFFF,
      secondary: AppColor.color0xFF4F4F4F,
      onSecondary: AppColor.color0xFFFACBBA,
      error: AppColor.color0xFFFFFFFF,
      onError: AppColor.color0xFFFFFFFF,
      surface: AppColor.color0xFF181818,
      onSurface: AppColor.color0xFFFFFFFF,
    ),
  );

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.color0xFFFFFFFF,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.color0xFF005C53,
      titleTextStyle: TextStyle(
        color: AppColor.color0xFFFFFFFF,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColor.color0xFF005C53,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.color0xFF005C53.withOpacity(0.3),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), //
        borderSide: BorderSide(
          color: AppColor.color0xFF005C53.withOpacity(0.3),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20), //
        borderSide: BorderSide(
          color: AppColor.color0xFF005C53.withOpacity(0.3),
          width: 1,
        ),
      ),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.color0xFF005C53,
      onPrimary: AppColor.color0xFF005C53,
      secondary: AppColor.color0xFF005C53,
      onSecondary: AppColor.color0xFFFFFFFF,
      error: AppColor.color0xFFFFFFFF,
      onError: AppColor.color0xFFFFFFFF,
      surface: AppColor.color0xFF005C53,
      onSurface: AppColor.color0xFFFFFFFF,
    ),
  );
}
