import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class InformationShowerTheme extends ThemeExtension<InformationShowerTheme> {
  final Color bgColor;
  final Color bgShadowColor;
  final Color fgColor;
  final Color fgShadowColor;

  const InformationShowerTheme({
    required this.bgColor,
    required this.bgShadowColor,
    required this.fgColor,
    required this.fgShadowColor,
  });

  @override
  ThemeExtension<InformationShowerTheme> copyWith({
    Color? bgColor,
    Color? bgShadowColor,
    Color? fgColor,
    Color? fgShadowColor,
  }) {
    return InformationShowerTheme(
      bgColor: bgColor ?? this.bgColor,
      bgShadowColor: bgShadowColor ?? this.bgShadowColor,
      fgColor: fgColor ?? this.fgColor,
      fgShadowColor: fgShadowColor ?? this.fgShadowColor,
    );
  }

  @override
  ThemeExtension<InformationShowerTheme> lerp(
      covariant ThemeExtension<InformationShowerTheme>? other, double t) {
    if (other is! InformationShowerTheme) return this;
    return InformationShowerTheme(
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      bgShadowColor: Color.lerp(bgShadowColor, other.bgShadowColor, t)!,
      fgColor: Color.lerp(fgColor, other.fgColor, t)!,
      fgShadowColor: Color.lerp(fgShadowColor, other.fgShadowColor, t)!,
    );
  }
}
