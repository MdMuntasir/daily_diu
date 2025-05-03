import 'package:diu_student/config/theme/custom%20themes/information_shower_theme.dart';
import 'package:flutter/material.dart';

import 'customText.dart';

class StudentInfoShow extends StatelessWidget {
  final String Name;
  final String ID;
  final String Department;
  final String Batch;
  final String Section;

  const StudentInfoShow({
    super.key,
    required this.Name,
    required this.ID,
    required this.Department,
    required this.Batch,
    required this.Section,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).extension<InformationShowerTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * .01, horizontal: w * .06),
      child: Container(
        width: w,
        height: h * .22,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.bgColor,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 15,
                color: theme.bgShadowColor,
              )
            ]),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                theme.bgShapeColor,
                BlendMode.srcATop,
              ),
              child: Image.asset(
                "assets/images/leaf.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: w * .07, vertical: h * .02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    first: "Name",
                    second: Name,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                  CustomText(
                    first: "ID",
                    second: ID,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                  CustomText(
                    first: "Department",
                    second: Department,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                  CustomText(
                    first: "Section",
                    second: "$Batch-$Section",
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherInfoShow extends StatelessWidget {
  final String Name;
  final String Faculty;
  final String Department;
  final String TeacherInitial;

  const TeacherInfoShow({
    super.key,
    required this.Name,
    required this.Department,
    required this.Faculty,
    required this.TeacherInitial,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).extension<InformationShowerTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * .01, horizontal: w * .06),
      child: Container(
        width: w,
        height: h * .22,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: theme.bgColor,
            boxShadow: [
              BoxShadow(
                spreadRadius: -10,
                blurRadius: 15,
                color: theme.bgShadowColor,
              )
            ]),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                theme.bgShapeColor,
                BlendMode.srcATop,
              ),
              child: Image.asset(
                "assets/images/leaf.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: w * .07, vertical: h * .02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    first: "Name",
                    second: Name,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                  CustomText(
                    first: "Teacher Initial",
                    second: TeacherInitial,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                  CustomText(
                    first: "Faculty",
                    second: Faculty,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                  CustomText(
                    first: "Department",
                    second: Department,
                    color: theme.fgColor,
                    shadowColor: theme.fgShadowColor,
                    size: 15,
                    separate: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
