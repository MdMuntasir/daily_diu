import 'package:flutter/material.dart';

@immutable
class ResultTheme extends ThemeExtension<ResultTheme> {
  final Color bgColor;
  final Color fgColor;
  final Color barColor;
  final List<Color> gradeColors;
  final Color lightBgColor;
  final Color darkFgColor;

  const ResultTheme({
    required this.bgColor,
    required this.fgColor,
    required this.barColor,
    required this.gradeColors,
    required this.lightBgColor,
    required this.darkFgColor,
  });

  @override
  ResultTheme copyWith({
    Color? bgColor,
    Color? fgColor,
    Color? barColor,
    List<Color>? gradeColors,
    Color? lightBgColor,
    Color? darkFgColor,
  }) {
    return ResultTheme(
      bgColor: bgColor ?? this.bgColor,
      fgColor: fgColor ?? this.fgColor,
      barColor: barColor ?? this.barColor,
      gradeColors: gradeColors ?? this.gradeColors,
      lightBgColor: lightBgColor ?? this.lightBgColor,
      darkFgColor: darkFgColor ?? this.darkFgColor,
    );
  }

  @override
  ResultTheme lerp(ThemeExtension<ResultTheme>? other, double t) {
    if (other is! ResultTheme) return this;
    return ResultTheme(
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      fgColor: Color.lerp(fgColor, other.fgColor, t)!,
      barColor: Color.lerp(barColor, other.barColor, t)!,
      gradeColors: List.generate(
        gradeColors.length,
        (index) => index < other.gradeColors.length
            ? Color.lerp(gradeColors[index], other.gradeColors[index], t)!
            : gradeColors[index],
      ),
      lightBgColor: Color.lerp(lightBgColor, other.lightBgColor, t)!,
      darkFgColor: Color.lerp(darkFgColor, other.darkFgColor, t)!,
    );
  }
}
