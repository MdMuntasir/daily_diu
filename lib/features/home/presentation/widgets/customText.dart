import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final bool separate;
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
      this.separate = false,
      this.shadowColor = Colors.teal,
      this.color = Colors.black87,
      this.size = 17.5,
      this.fontFamily = "Welcome_Magic"});

  @override
  Widget build(BuildContext context) {
    return separate
        ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("$first : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: size,
                  color: color,
                  fontFamily: fontFamily,
                )),
            Text(second,
                style: TextStyle(
                  fontSize: size,
                  color: color,
                  fontFamily: fontFamily,
                )),
          ])
        : RichText(
            text: TextSpan(children: [
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
