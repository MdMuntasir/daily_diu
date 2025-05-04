import 'package:diu_student/config/theme/custom%20themes/result_theme.dart';
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
    final theme = Theme.of(context).extension<ResultTheme>()!;

    TextStyle style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 19, color: theme.fgColor);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: w * .3,
        width: w * .4,
        decoration: BoxDecoration(
            color: theme.lightBgColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: -5,
              )
            ]),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                theme.bgColor,
                BlendMode.srcATop,
              ),
              child: Image.asset(
                "assets/images/leaf.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
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
          ],
        ),
      ),
    );
  }
}
