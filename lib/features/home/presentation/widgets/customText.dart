import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String first;
  final String second;
  final double size;
  final Color color;
  final Color shadowColor;
  final String fontFamily;

  const CustomText(
      {super.key,
      required this.first,
      required this.second,
      this.shadowColor = Colors.teal,
      this.color = Colors.black87,
      this.size = 17.5,
      this.fontFamily = "Welcome_Magic"});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          // style: TextStyle(shadows: [
          //   Shadow(color: shadowColor, blurRadius: 2, offset: Offset(1, 1.5))
          // ]),
          children: [
            TextSpan(
                text: "$first : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size,
                  color: color,
                  fontFamily: fontFamily,
                )),
            TextSpan(
                text: second,
                style: TextStyle(
                  fontSize: size,
                  color: color,
                  fontFamily: fontFamily,
                )),
          ]),
    );
  }
}
