import 'package:flutter/material.dart';

@immutable
class FormTheme extends ThemeExtension<FormTheme> {
  final Color lightColor;
  final Color deepColor;
  final Color bgColor;
  final Color chooserBgColor;
  final Color chooserFgColor;
  final Color submitBgColor;
  final Color submitFgColor;
  final Color sliderFgColor;
  final Color sliderBgColor;

  const FormTheme({
    required this.lightColor,
    required this.deepColor,
    required this.bgColor,
    required this.chooserBgColor,
    required this.chooserFgColor,
    required this.submitBgColor,
    required this.submitFgColor,
    required this.sliderFgColor,
    required this.sliderBgColor,
  });

  @override
  FormTheme copyWith({
    Color? lightColor,
    Color? deepColor,
    Color? bgColor,
    Color? chooserBgColor,
    Color? chooserFgColor,
    Color? submitBgColor,
    Color? submitFgColor,
    Color? sliderFgColor,
    Color? sliderBgColor,
  }) {
    return FormTheme(
      lightColor: lightColor ?? this.lightColor,
      deepColor: deepColor ?? this.deepColor,
      bgColor: bgColor ?? this.bgColor,
      chooserBgColor: chooserBgColor ?? this.chooserBgColor,
      chooserFgColor: chooserFgColor ?? this.chooserFgColor,
      submitBgColor: submitBgColor ?? this.submitBgColor,
      submitFgColor: submitFgColor ?? this.submitFgColor,
      sliderFgColor: sliderFgColor ?? this.sliderFgColor,
      sliderBgColor: sliderBgColor ?? this.sliderBgColor,
    );
  }

  @override
  FormTheme lerp(ThemeExtension<FormTheme>? other, double t) {
    if (other is! FormTheme) return this;
    return FormTheme(
      lightColor: Color.lerp(lightColor, other.lightColor, t)!,
      deepColor: Color.lerp(deepColor, other.deepColor, t)!,
      bgColor: Color.lerp(bgColor, other.bgColor, t)!,
      chooserBgColor: Color.lerp(chooserBgColor, other.chooserBgColor, t)!,
      chooserFgColor: Color.lerp(chooserFgColor, other.chooserFgColor, t)!,
      submitBgColor: Color.lerp(submitBgColor, other.submitBgColor, t)!,
      submitFgColor: Color.lerp(submitFgColor, other.submitFgColor, t)!,
      sliderFgColor: Color.lerp(sliderFgColor, other.sliderFgColor, t)!,
      sliderBgColor: Color.lerp(sliderBgColor, other.sliderBgColor, t)!,
    );
  }
}
