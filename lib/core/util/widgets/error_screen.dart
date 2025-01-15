import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;

  const ErrorScreen({
    super.key,
    required this.onPressed,
    this.message = "Oops! Something Went Wrong",
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;

    TextStyle style = TextStyle(
      color: Colors.teal.shade900,
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: h * .02,
      children: [
        Lottie.asset(
          "assets/lottie/Error.json",
          width: w * .7,
          height: w * .7,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: w,
        ),
        SizedBox(
          width: w * .6,
          child: Center(
            child: Text(
              message,
              style: style,
            ),
          ),
        ),
        OutlinedButton(
          onPressed: onPressed,
          child: Text(
            "Refresh",
            style: style.copyWith(fontSize: 12),
          ),
        )
      ],
    );
  }
}
