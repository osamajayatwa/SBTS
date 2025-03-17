import 'package:bus_tracking_users/core/constant/color.dart';
import 'package:flutter/material.dart';

ThemeData themeEnglish = ThemeData(
  fontFamily: "Roboto",
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    bodyLarge: TextStyle(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12),
  ),
  brightness: Brightness.light,
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    bodyLarge: TextStyle(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12),
  ),
  brightness: Brightness.light,
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

ThemeData darkThemeEnglish = ThemeData(
  fontFamily: "Roboto",
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    bodyLarge: TextStyle(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12),
  ),
  brightness: Brightness.dark,
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);

ThemeData darkThemeArabic = ThemeData(
  fontFamily: "Cairo",
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
    headlineLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
    bodyLarge: TextStyle(
        height: 2,
        color: AppColor.grey,
        fontWeight: FontWeight.bold,
        fontSize: 12),
  ),
  brightness: Brightness.dark,
  primaryColor: AppColor.primaryColor,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: AppColor.primaryColor,
    iconTheme: IconThemeData(color: Colors.white),
  ),
);
