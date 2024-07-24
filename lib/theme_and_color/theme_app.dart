import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_app.dart';

class ThemeApp {
  static final ThemeData themeLight = ThemeData(
    primaryColor: ColorApp.primaryColor,
    scaffoldBackgroundColor: ColorApp.backgroundLightColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: ColorApp.primaryColor,
        foregroundColor: ColorApp.whiteColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: ColorApp.primaryColor,
        unselectedItemColor: ColorApp.grayColor,
        showSelectedLabels: false),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
            side: const BorderSide(color: ColorApp.whiteColor, width: 4)),
        backgroundColor: ColorApp.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(ColorApp.primaryColor),
    )),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.poppins(
          color: ColorApp.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 22),
      titleLarge: GoogleFonts.poppins(
          color: ColorApp.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      titleSmall: GoogleFonts.poppins(
          color: ColorApp.blackColor,
          fontWeight: FontWeight.w400,
          fontSize: 12),
      bodyMedium: GoogleFonts.poppins(
          color: ColorApp.blackColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      bodySmall: GoogleFonts.inter(
          color: ColorApp.grayColor, fontWeight: FontWeight.w400, fontSize: 20),
    ),
  );

  static final ThemeData themeDark = ThemeData(
    primaryColor: ColorApp.primaryColor,
    scaffoldBackgroundColor: ColorApp.backgroundDarkColor,
    appBarTheme: const AppBarTheme(
        backgroundColor: ColorApp.primaryColor,
        foregroundColor: ColorApp.backgroundDarkColor),
    bottomAppBarTheme: BottomAppBarTheme(color: ColorApp.itemsDarkColor),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: ColorApp.primaryColor,
        unselectedItemColor: ColorApp.whiteColor,
        showSelectedLabels: false),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(34),
            side: const BorderSide(
                color: ColorApp.backgroundDarkColor, width: 4)),
        backgroundColor: ColorApp.primaryColor),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(ColorApp.primaryColor),
    )),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.poppins(
          color: ColorApp.itemsDarkColor,
          fontWeight: FontWeight.bold,
          fontSize: 22),
      titleLarge: GoogleFonts.poppins(
          color: ColorApp.primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      titleSmall: GoogleFonts.poppins(
          color: ColorApp.whiteColor,
          fontWeight: FontWeight.w400,
          fontSize: 12),
      bodyMedium: GoogleFonts.poppins(
          color: ColorApp.whiteColor,
          fontWeight: FontWeight.bold,
          fontSize: 18),
      bodySmall: GoogleFonts.inter(
          color: ColorApp.grayColor, fontWeight: FontWeight.w400, fontSize: 20),
    ),
  );
}
