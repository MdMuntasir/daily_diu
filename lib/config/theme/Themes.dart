import 'package:diu_student/config/theme/custom%20themes/bottom_panel_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/information_shower_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/slot_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightA = Color(0xFFD6EFD8);
const lightB = Color(0xFF80AF81);
const lightC = Color(0xFF508D4E);
const lightD = Color(0xFF1A5319);

ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
    scaffoldBackgroundColor: lightA,
    appBarTheme: AppBarTheme(color: Colors.transparent),
    useMaterial3: true,
    primaryColor: Colors.teal,
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.teal),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))))),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: const WidgetStatePropertyAll(Colors.teal),
          textStyle: WidgetStatePropertyAll(TextStyle(
            color: Colors.teal.shade800,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ))),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 45,
        color: Colors.teal.shade900,
        fontWeight: FontWeight.bold,
        fontFamily: "Welcome_Magic",
        shadows: const [
          Shadow(color: Colors.black87, offset: Offset(.5, 1.5), blurRadius: 5)
        ],
      ),
      displayMedium: GoogleFonts.irishGrover(
        color: lightD,
        fontSize: 35,
        fontWeight: FontWeight.bold,
      ),
      // bodyMedium: const TextStyle(fontSize: 14, fontFamily: "Welcome_Magic"),
    ),
    extensions: const <ThemeExtension<dynamic>>[
      InformationShowerTheme(
        bgColor: lightC,
        bgShadowColor: Colors.teal,
        fgColor: lightA,
        fgShadowColor: Colors.black87,
      ),
      SlotTheme(
        fgColor: lightA,
        bgColor: lightD,
        activeBgColor: lightC,
      ),
      BottomPanelTheme(
        iconBgColor: lightD,
        iconFgColor: lightA,
        bgColor: lightB,
        barColor: lightA,
      ),
    ]);

// 0xFFF6F4F0
// 0xFF79D7BE
// 0xFF4DA1A9
// 0xFF2E5077
