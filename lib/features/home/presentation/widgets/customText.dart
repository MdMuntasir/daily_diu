import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String first;
  final String second;
  final double size;
  const CustomText({super.key, required this.first, required this.second, this.size = 18});

  @override
  Widget build(BuildContext context) {
    return RichText(text: TextSpan(
      children: [
        TextSpan(
          text: first + " : ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: size,color: Colors.black)
        ),
        TextSpan(
          text: second,
          style: TextStyle( fontSize: size, color: Colors.black)
        ),
      ]
    ),);
  }
}
