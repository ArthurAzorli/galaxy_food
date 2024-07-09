import 'package:flutter/material.dart';

class GalaxyFoodTheme {

  static ThemeData get normal{
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffde204d),
        onPrimary: Color(0xdaf62e60),
        secondary: Color(0xffffffff),
        onSecondary: Color(0xfffafafa),
        tertiary: Color(0xff1e293e),
        onTertiary: Color(0xda204173),
        surface: Color(0xff2a2829),
        onSurface: Color(0xff373535),
        primaryContainer: Color(0xff000000),
        inverseSurface: Color(0xffafafaf),
        error: Color(0xffbb0000),
        onError: Color(0xffa90000)
      ),
      fontFamily: 'Montserrat',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xff000000),
          fontSize: 57
        ),
        displayMedium: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff000000),
            fontSize: 45
        ),
        displaySmall: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff000000),
            fontSize: 36
        ),
        headlineLarge: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xffffffff),
            fontSize: 32,
        ),
        headlineMedium: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xffffffff),
            fontSize: 28
        ),
        headlineSmall: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xffffffff),
            fontSize: 24
        ),
        titleLarge: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xffffffff),
            fontSize: 22,
            fontWeight: FontWeight.w600
        ),
        titleMedium: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xffffffff),
            fontSize: 16,
            fontWeight: FontWeight.w600
        ),
        titleSmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
        bodyLarge: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 16,
        ),
        bodyMedium: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 14,
        ),
        bodySmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 12,
        ),
        labelLarge: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 14,
        ),
        labelMedium: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 11,
        ),
      ),
      dividerColor: const Color(0xffcccccc)
    );
  }
}