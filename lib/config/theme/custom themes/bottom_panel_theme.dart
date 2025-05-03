import 'package:flutter/material.dart';

@immutable
class BottomPanelTheme extends ThemeExtension<BottomPanelTheme> {
  final Color iconBgColor;
  final Color iconFgColor;
  final Color bgColor;
  final Color barColor;
  final Color bgShapeColor;

  const BottomPanelTheme({
    required this.iconBgColor,
    required this.iconFgColor,
    required this.bgColor,
    required this.barColor,
    required this.bgShapeColor,
  });

  @override
  BottomPanelTheme copyWith({
    Color? iconBgColor,
    Color? iconFgColor,
    Color? bgColor,
    Color? barColor,
    Color? bgShapeColor,
  }) {
    return BottomPanelTheme(
      iconBgColor: iconBgColor ?? this.iconBgColor,
      iconFgColor: iconFgColor ?? this.iconFgColor,
      bgColor: bgColor ?? this.bgColor,
      barColor: barColor ?? this.barColor,
      bgShapeColor: bgShapeColor ?? this.bgShapeColor,
    );
  }

  @override
  BottomPanelTheme lerp(ThemeExtension<BottomPanelTheme>? other, double t) {
    if (other is! BottomPanelTheme) return this;
    return BottomPanelTheme(
      iconBgColor: Color.lerp(iconBgColor, other.iconBgColor, t)!,
      iconFgColor: Color.lerp(iconFgColor, other.iconFgColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      barColor: Color.lerp(barColor, other.barColor, t)!,
      bgShapeColor: Color.lerp(bgShapeColor, other.bgShapeColor, t)!,
    );
  }
}
