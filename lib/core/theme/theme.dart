import 'package:flutter/material.dart';

import 'app_pallete.dart';

class AppTheme {
  static _border([Color color = AppPallete.borderColor]) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: color,
          width: 3,
        ),
      );
  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
        color: WidgetStatePropertyAll(AppPallete.backgroundColor),
        side: BorderSide.none),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(25),
      border: _border(),
      errorBorder: _border(AppPallete.errorColor),
      enabledBorder: _border(),
      focusedBorder: _border(AppPallete.gradient2),
    ),
  );
}
