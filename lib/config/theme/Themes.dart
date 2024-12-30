import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  scaffoldBackgroundColor: Colors.blue.shade50,
  appBarTheme: AppBarTheme(color: Colors.transparent),
  useMaterial3: true,
  primaryColor: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.blue.shade900),
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
        color: Colors.blue.shade900,
        fontWeight: FontWeight.bold,
      fontFamily: "Welcome_Magic",
      shadows: [Shadow(
        color: Colors.black87,
        offset: Offset(.5, 1.5),
        blurRadius: 5
      )],

    ),


  ),
  
);