import 'package:assignment/core/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    brightness: Brightness.light,
    textTheme: GoogleFonts.interTextTheme(),
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.black,
    brightness: Brightness.dark,
    textTheme: GoogleFonts.interTextTheme(),
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
  );
}