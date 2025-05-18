import 'package:flutter/material.dart';

@immutable
class RoutineTheme extends ThemeExtension<RoutineTheme> {
  final Color fgColor;
  final Color bgColor;
  final Color deepColor;
  final Color lightColor;
  final Color inactiveFgColor;
  final Color inactiveBgColor;
  final Color chooserColor;
  final Color optionChooserBgColor;
  final Color optionChooserFgColor;

  const RoutineTheme({
    required this.fgColor,
    required this.bgColor,
    required this.deepColor,
    required this.lightColor,
    required this.inactiveFgColor,
    required this.inactiveBgColor,
    required this.chooserColor,
    required this.optionChooserBgColor,
    required this.optionChooserFgColor,
  });

  @override
  RoutineTheme copyWith({
    Color? fgColor,
    Color? bgColor,
    Color? deepColor,
    Color? lightColor,
    Color? inactiveFgColor,
    Color? inactiveBgColor,
    Color? chooserColor,
    Color? optionChooserBgColor,
    Color? optionChooserFgColor,
  }) {
    return RoutineTheme(
      fgColor: fgColor ?? this.fgColor,
      bgColor: bgColor ?? this.bgColor,
      deepColor: deepColor ?? this.deepColor,
      lightColor: lightColor ?? this.lightColor,
      inactiveFgColor: inactiveFgColor ?? this.inactiveFgColor,
      inactiveBgColor: inactiveBgColor ?? this.inactiveBgColor,
      chooserColor: chooserColor ?? this.chooserColor,
      optionChooserBgColor: optionChooserBgColor ?? this.optionChooserBgColor,
      optionChooserFgColor: optionChooserFgColor ?? this.optionChooserFgColor,
    );
  }

  @override
  RoutineTheme lerp(ThemeExtension<RoutineTheme>? other, double t) {
    if (other is! RoutineTheme) return this;
    return RoutineTheme(
      fgColor: Color.lerp(fgColor, other.fgColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      deepColor: Color.lerp(deepColor, other.deepColor, t)!,
      lightColor: Color.lerp(lightColor, other.lightColor, t)!,
      inactiveFgColor: Color.lerp(inactiveFgColor, other.inactiveFgColor, t)!,
      inactiveBgColor: Color.lerp(inactiveBgColor, other.inactiveBgColor, t)!,
      chooserColor: Color.lerp(chooserColor, other.chooserColor, t)!,
      optionChooserBgColor:
          Color.lerp(optionChooserBgColor, other.optionChooserBgColor, t)!,
      optionChooserFgColor:
          Color.lerp(optionChooserFgColor, other.optionChooserFgColor, t)!,
    );
  }
}
