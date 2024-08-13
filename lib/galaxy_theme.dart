import 'package:flutter/material.dart';

class GalaxyFoodTheme {

  static ThemeData get normal {
    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: Color(0xfff10404),
          onPrimary: Color(0xff9e1414),
          secondary: Color(0xffffffff),
          onSecondary: Color(0xfffafafa),
          tertiary: Color(0xff6666ff),
          onTertiary: Color(0xff373787),
          surface: Color(0xff202020),
          onSurface: Color(0xff353535),
          primaryContainer: Color(0xff000000),
          onPrimaryContainer: Color(0xca000000),
          secondaryContainer: Color(0x67040404),
          tertiaryContainer: Color(0xff2c2c2c),
          inverseSurface: Color(0xffafafaf),
          inversePrimary: Colors.orangeAccent,
          error: Color(0xffbb0000),
          onError: Color(0xffff2121)
      ),
      fontFamily: 'Montserrat',
      textTheme: const TextTheme(
        displayLarge: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff000000),
            fontSize: 57,
          fontWeight: FontWeight.w600,
        ),
        displayMedium: TextStyle(
            fontFamily: 'Montserrat',
            color: Color(0xff000000),
            fontSize: 45,
          fontWeight: FontWeight.w600,
        ),
        displaySmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 32,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 28,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffffffff),
          fontSize: 24,
          fontWeight: FontWeight.w600,
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
          color: Color(0xffafafaf),
          fontSize: 12,
        ),
        labelSmall: TextStyle(
          fontFamily: 'Montserrat',
          color: Color(0xffcccccc),
          fontSize: 11,
        ),
      ),
      dividerColor: const Color(0xff2f2f2f),
    );
  }
}