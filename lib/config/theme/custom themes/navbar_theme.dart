import 'package:flutter/material.dart';

@immutable
class NavbarTheme extends ThemeExtension<NavbarTheme> {
  final Color bgColor;
  final Color fgColor;
  final Color developerBgColor;
  final Color developerFgColor;
  final Color iconColor;
  final Color shapeColor;

  const NavbarTheme({
    required this.bgColor,
    required this.fgColor,
    required this.developerBgColor,
    required this.developerFgColor,
    required this.iconColor,
    required this.shapeColor,
  });

  @override
  NavbarTheme copyWith({
    Color? bgColor,
    Color? fgColor,
    Color? developerBgColor,
    Color? developerFgColor,
    Color? iconColor,
    Color? shapeColor,
  }) {
    return NavbarTheme(
      bgColor: bgColor ?? this.bgColor,
      fgColor: fgColor ?? this.fgColor,
      developerBgColor: developerBgColor ?? this.developerBgColor,
      developerFgColor: developerFgColor ?? this.developerFgColor,
      iconColor: iconColor ?? this.iconColor,
      shapeColor: shapeColor ?? this.shapeColor,
    );
  }

  @override
  NavbarTheme lerp(ThemeExtension<NavbarTheme>? other, double t) {
    if (other is! NavbarTheme) return this;
    return NavbarTheme(
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      fgColor: Color.lerp(fgColor, other.fgColor, t)!,
      developerBgColor:
          Color.lerp(developerBgColor, other.developerBgColor, t)!,
      developerFgColor:
          Color.lerp(developerFgColor, other.developerFgColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      shapeColor: Color.lerp(shapeColor, other.shapeColor, t)!,
    );
  }
}
