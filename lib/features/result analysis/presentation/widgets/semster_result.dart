import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SemesterResult extends StatelessWidget {
  final double gpa;
  final String semester;
  final VoidCallback onTap;

  const SemesterResult(
      {super.key,
      required this.gpa,
      required this.semester,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    TextStyle style = const TextStyle(
        fontWeight: FontWeight.bold, fontSize: 19, color: Colors.white);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: w * .3,
        width: w * .4,
        decoration: BoxDecoration(
            color: Colors.teal.shade600,
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(color: Colors.cyan.shade800, width: 2),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -5,
              )
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: w * .075),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                gpa.toString(),
                style: style,
              ),
              Text(
                semester,
                style: style,
              )
            ],
          ),
        ),
      ),
    );
  }
}
