import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  scaffoldBackgroundColor: Colors.blue.shade50,
  appBarTheme: AppBarTheme(color: Colors.transparent),
  useMaterial3: true,
  primaryColor: Colors.blue,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Colors.blue.shade900),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
      shape: const MaterialStatePropertyAll(RoundedRectangleBorder
        (borderRadius: BorderRadius.all(Radius.circular(10))
      )
      )
    )
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
        fontSize: 45,
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold
    ),

  ),
  
);



