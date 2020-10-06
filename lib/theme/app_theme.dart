import 'package:flutter/material.dart';

const brightness = Brightness.light;

//const accentColor = const Color(0xFF63B4D1);
const accentColor = const Color(0xFF004ba0);
const primaryColor = const Color(0xFF1976d2);
const backgroundColor = const Color(0xFFe0e0e0);
const buttonColor = const Color(0xFF63a4ff);
const appBarTheme = const Color(0xFF63a4ff);

ThemeData appTheme() {
  return ThemeData(
    buttonColor: buttonColor,
    appBarTheme: AppBarTheme(color: appBarTheme),
    brightness: brightness,
    textTheme: new TextTheme(
    ),
    primaryColorDark: primaryColor,
    primaryColor:  primaryColor,
    accentColor: accentColor,
    scaffoldBackgroundColor: backgroundColor,
  );
}