import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.blackColor,
    primaryColor: AppColors.yellowColor,

    colorScheme: ColorScheme.dark(
      primary: AppColors.yellowColor,
      secondary: AppColors.redColor,
      surface: AppColors.darkGrayColor,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.blackColor,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: AppColors.yellowColor),
      elevation: 0,
      centerTitle: false,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkGrayColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: AppColors.redColor, width: 1),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
  );
}
