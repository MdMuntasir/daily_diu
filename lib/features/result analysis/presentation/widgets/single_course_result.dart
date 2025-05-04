import 'package:diu_student/config/theme/custom%20themes/result_theme.dart';
import 'package:diu_student/features/result%20analysis/domain/entities/semesterResultEntity.dart';
import 'package:flutter/material.dart';

class SingleCourseResult extends StatelessWidget {
  final SemesterResultEntity result;

  const SingleCourseResult({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.sizeOf(context).width;

    final theme = Theme.of(context).extension<ResultTheme>()!;

    double maxHeight = 155, barWidth = w * .05;

    final double fillHeight =
        maxHeight * (0.15 + .7 * ((result.pointEquivalent - 2) / 2));

    TextStyle style = TextStyle(
        fontWeight: FontWeight.bold, fontSize: 13, color: theme.fgColor);

    final Color barColor = result.pointEquivalent >= 3.75
        ? theme.gradeColors[0]
        : result.pointEquivalent >= 3.0
            ? theme.gradeColors[1]
            : result.pointEquivalent >= 2.5
                ? theme.gradeColors[2]
                : theme.gradeColors[3];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * .07),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: w * .05, vertical: 9),
        height: 150,
        decoration: BoxDecoration(
            color: theme.bgColor, borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .05, vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: w * .7 * .75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      "Course: ${result.courseTitle}",
                      style: style,
                    ),
                    Text(
                      "Course Code: ${result.customCourseId}",
                      style: style,
                    ),
                    Text(
                      "GPA: ${result.pointEquivalent.toString()}",
                      style: style.copyWith(color: barColor),
                    ),
                    Text(
                      "Grade: ${result.gradeLetter}",
                      style: style,
                    ),
                    Text(
                      "Total Credit: ${result.totalCredit.toString()}",
                      style: style,
                    ),
                  ],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Background bar
                  Container(
                    height: maxHeight,
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  // Filled portion
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: fillHeight,
                    width: barWidth,
                    decoration: BoxDecoration(
                      color: barColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
