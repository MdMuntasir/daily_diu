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
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;
    final theme = Theme.of(context).extension<InformationShowerTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: h * .01, horizontal: w * .06),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: w * .07, vertical: h * .02),
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
    );
  }
}

class TeacherInfoShow extends StatelessWidget {
  final String Name;
  final String Faculty;
  final String Department;
  final String TeacherInitial;
  final Gradient grad;

  const TeacherInfoShow({
    super.key,
    required this.Name,
    required this.Department,
    required this.Faculty,
    required this.TeacherInitial,
    required this.grad,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery
        .of(context)
        .size
        .height;
    double w = MediaQuery
        .of(context)
        .size
        .width;
    bool horizontal = h > w;
    double round = horizontal ? w * .15 : h * .25;

    return Container(
      width: horizontal ? w : w * .8,
      height: horizontal ? h * .4 : h * .6,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: grad,
        boxShadow: const [
          BoxShadow(spreadRadius: -10, blurRadius: 20, color: Colors.blue)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(round),
            bottomRight: Radius.circular(round)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * .08,
            ),
            Text(
              "Welcome " + Name,
              style: Theme
                  .of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(
                  fontSize: horizontal ? w * .085 : 40,
                  color: Colors.teal.shade800,
                  fontFamily: "Funky_Coffee"),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: h * .045,
            ),
            CustomText(
              first: "Teacher Initial",
              second: TeacherInitial,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
              separate: true,
            ),
            SizedBox(
              height: h * .03,
            ),
            CustomText(
              first: "Faculty",
              second: Faculty,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
              separate: true,
            ),
            SizedBox(
              height: h * .03,
            ),
            CustomText(
              first: "Department",
              second: Department
                  .split("+")
                  .length > 1
                  ? "${Department.split("+")[0]}..."
                  : Department,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
              separate: true,
            ),
          ],
        ),
      ),
    );
  }
}


