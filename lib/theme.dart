import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

// Our light/Primary Theme
ThemeData themeData(BuildContext context) {
  return ThemeData(
    appBarTheme: appBarTheme,
    primaryColor: tPrimaryColor,
    // accentColor: tAccentLightColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(
      secondary: tSecondaryLightColor,
      background: Colors.white,
      // on light theme surface = Colors.white by default
    ),
    // backgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: tBodyTextColorLight),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: tAccentIconLightColor,
    ),
    primaryIconTheme: const IconThemeData(color: tPrimaryIconLightColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge: const TextStyle(color: tBodyTextColorLight),
      bodyMedium: const TextStyle(color: tBodyTextColorLight),
      headlineMedium:
          const TextStyle(color: tTitleTextLightColor, fontSize: 32),
      displayLarge: const TextStyle(color: tTitleTextLightColor, fontSize: 80),
    ),
  );
}

// Dark Them
ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
    primaryColor: tPrimaryColor,
    // accentColor: tAccentDarkColor,
    scaffoldBackgroundColor: const Color(0xFF0D0C0E),
    appBarTheme: appBarTheme,
    colorScheme: const ColorScheme.light(
      secondary: tSecondaryDarkColor,
      surface: tSurfaceDarkColor,
      background: tBackgroundDarkColor,
    ),
    iconTheme: const IconThemeData(color: tBodyTextColorDark),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      foregroundColor: tAccentIconDarkColor,
    ),
    primaryIconTheme: const IconThemeData(color: tPrimaryIconDarkColor),
    textTheme: GoogleFonts.latoTextTheme().copyWith(
      bodyLarge: const TextStyle(color: tBodyTextColorDark),
      bodyMedium: const TextStyle(color: tBodyTextColorDark),
      headlineMedium: const TextStyle(color: tTitleTextDarkColor, fontSize: 32),
      displayLarge: const TextStyle(color: tTitleTextDarkColor, fontSize: 80),
    ),
  );
}

AppBarTheme appBarTheme =
    const AppBarTheme(color: Colors.transparent, elevation: 0);
