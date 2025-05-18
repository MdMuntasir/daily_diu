import 'package:diu_student/config/theme/custom%20themes/bottom_panel_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/form_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/information_shower_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/navbar_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/result_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/routine_theme.dart';
import 'package:diu_student/config/theme/custom%20themes/slot_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightA = Color(0xFFD6EFD8);
const lightB = Color(0xFF80AF81);
const lightC = Color(0xFF508D4E);
const lightD = Color(0xFF1A5319);

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: lightC),
    scaffoldBackgroundColor: lightA,
    appBarTheme: const AppBarTheme(color: Colors.transparent),
    useMaterial3: true,
    primaryColor: lightC,
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(lightC),
            foregroundColor: WidgetStatePropertyAll(lightA),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))))),
    outlinedButtonTheme: const OutlinedButtonThemeData(
      style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(lightC),
          textStyle: WidgetStatePropertyAll(TextStyle(
            color: lightD,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ))),
    ),
    textTheme: TextTheme(
        displayLarge: const TextStyle(
          fontSize: 45,
          color: lightD,
          fontWeight: FontWeight.bold,
          fontFamily: "Welcome_Magic",
          shadows: [
            Shadow(
                color: Colors.black87, offset: Offset(.5, 1.5), blurRadius: 5)
          ],
        ),
        displayMedium: GoogleFonts.dynaPuff(
          color: lightD,
          fontSize: 35,
        ),
        bodyMedium: TextStyle(color: lightD)
        // bodyMedium: const TextStyle(fontSize: 14, fontFamily: "Welcome_Magic"),
        ),
    extensions: <ThemeExtension<dynamic>>[
      const InformationShowerTheme(
        bgColor: lightC,
        bgShapeColor: lightB,
        bgShadowColor: lightC,
        fgColor: lightA,
        fgShadowColor: Colors.black87,
      ),
      const SlotTheme(
        fgColor: lightA,
        bgColor: lightD,
        activeBgColor: lightC,
      ),
      const BottomPanelTheme(
        iconBgColor: lightD,
        iconFgColor: lightA,
        bgColor: lightB,
        bgShapeColor: lightC,
        barColor: lightA,
      ),
      const RoutineTheme(
          fgColor: lightA,
          bgColor: lightC,
          deepColor: lightD,
          lightColor: lightB,
          optionChooserBgColor: lightB,
          optionChooserFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          chooserColor: Colors.white),
      ResultTheme(
        bgColor: lightD,
        fgColor: lightA,
        barColor: Colors.white,
        lightBgColor: lightC,
        darkFgColor: lightB,
        gradeColors: [
          Colors.greenAccent,
          Colors.cyanAccent,
          Colors.orangeAccent,
          Colors.redAccent.shade100
        ],
      ),
      const FormTheme(
        lightColor: lightA,
        deepColor: lightD,
        bgColor: Colors.white,
        chooserBgColor: lightC,
        chooserFgColor: lightA,
        submitBgColor: lightB,
        submitFgColor: Colors.white,
        sliderBgColor: lightC,
        sliderFgColor: Colors.white,
      ),
      const NavbarTheme(
          bgColor: lightA,
          fgColor: lightD,
          developerBgColor: Colors.white,
          developerFgColor: lightC,
          iconColor: lightB,
          shapeColor: lightC),
    ]);

// 0xFFF6F4F0
// 0xFF79D7BE
// 0xFF4DA1A9
// 0xFF2E5077
