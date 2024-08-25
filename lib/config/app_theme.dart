import 'package:data_base/config/app_color.dart';
import 'package:data_base/config/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    buttonTheme: const ButtonThemeData(buttonColor: AppColor.buttonColor),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(AppColor.buttonColor))),
    fontFamily: GoogleFonts.roboto().fontFamily,
    scaffoldBackgroundColor: AppColor.scaffoldbackgroundColor,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.appBarbackgroundColor,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: AppColor.white,
      ),
      titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, color: AppColor.white),
      titleSpacing: 0,
    ),
    iconTheme: const IconThemeData(),
    colorScheme: const ColorScheme.light(
      primary: AppColor.backgroundColor,
      onPrimary: AppColor.onPrimary,
    ).copyWith(background: AppColor.onPrimary),
    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppLayout.cornerRadius,
        ),
      ),
    ),
  );
}
