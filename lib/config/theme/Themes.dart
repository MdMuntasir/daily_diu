import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
  scaffoldBackgroundColor: Colors.teal.shade50,
  appBarTheme: AppBarTheme(color: Colors.transparent),
  useMaterial3: true,
  primaryColor: Colors.teal,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.teal),
        foregroundColor: const WidgetStatePropertyAll(Colors.white),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder
        (borderRadius: BorderRadius.all(Radius.circular(10))
      )
      )
    )
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontSize: 45,
        color: Colors.teal.shade900,
        fontWeight: FontWeight.bold,
      fontFamily: "Welcome_Magic",
      shadows: [Shadow(
        color: Colors.black87,
        offset: Offset(.5, 1.5),
        blurRadius: 5
      )],

    ),
    displayMedium: TextStyle(
      fontSize: 35,
      color: Colors.green.shade900,
      fontWeight: FontWeight.bold,
      fontFamily: "Welcome_Magic",
      shadows: [Shadow(
          color: Colors.black87,
          offset: Offset(.5, 1.5),
          blurRadius: 5
      )],
    )

  ),
  
);