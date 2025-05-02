import 'package:flutter/material.dart';

@immutable
class SlotTheme extends ThemeExtension<SlotTheme> {
  final Color fgColor;
  final Color bgColor;
  final Color activeBgColor;

  const SlotTheme({
    required this.fgColor,
    required this.bgColor,
    required this.activeBgColor,
  });

  @override
  SlotTheme copyWith({
    Color? fgColor,
    Color? bgColor,
    Color? activeBgColor,
  }) {
    return SlotTheme(
      fgColor: fgColor ?? this.fgColor,
      bgColor: bgColor ?? this.bgColor,
      activeBgColor: activeBgColor ?? this.activeBgColor,
    );
  }

  @override
  SlotTheme lerp(ThemeExtension<SlotTheme>? other, double t) {
    if (other is! SlotTheme) return this;
    return SlotTheme(
      fgColor: Color.lerp(fgColor, other.fgColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      activeBgColor: Color.lerp(activeBgColor, other.activeBgColor, t)!,
    );
  }
}
