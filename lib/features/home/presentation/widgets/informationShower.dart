import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customText.dart';

class StudentInfoShow extends StatelessWidget {
  final String Name;
  final String ID;
  final String Department;
  final String Batch;
  final String Section;
  final Gradient grad;

  const StudentInfoShow(
      {super.key,
      required this.Name,
      required this.ID,
      required this.Department,
      required this.Batch,
      required this.Section,
      required this.grad});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h > w;
    double round = horizontal ? w * .1 : h * .2;

    return Container(
      width: horizontal ? w : w * .8,
      height: horizontal ? h * .38 : h * .6,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: grad,
        boxShadow: [
          BoxShadow(spreadRadius: -10, blurRadius: 20, color: Colors.blue)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(round),
            bottomRight: Radius.circular(round)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * .08,
            ),
            SizedBox(
              width: horizontal ? w : w * .8,
              child: Center(
                child: Text(
                  "Welcome " + Name,
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: horizontal ? w * .085 : 40,
                      color: Colors.teal.shade800,
                      fontFamily: "Funky_Coffee"),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: h * .045,
            ),
            CustomText(
              first: "ID",
              second: ID,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
            ),
            SizedBox(
              height: h * .03,
            ),
            CustomText(
              first: "Department",
              second: Department,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
            ),
            SizedBox(
              height: h * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  first: "Batch",
                  second: Batch,
                  color: Colors.teal.shade700,
                  shadowColor: Colors.black45,
                ),
                SizedBox(
                  width: w * .001,
                ),
                CustomText(
                  first: "Section",
                  second: Section,
                  color: Colors.teal.shade700,
                  shadowColor: Colors.black45,
                ),
                SizedBox(
                  width: w * .001,
                )
              ],
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h > w;
    double round = horizontal ? w * .15 : h * .25;

    return Container(
      width: horizontal ? w : w * .8,
      height: horizontal ? h * .4 : h * .6,
      decoration: BoxDecoration(
        color: Colors.white,
        gradient: grad,
        boxShadow: [
          BoxShadow(spreadRadius: -10, blurRadius: 20, color: Colors.blue)
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(round),
            bottomRight: Radius.circular(round)),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h * .08,
            ),
            Text(
              "Welcome " + Name,
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
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
            ),
            SizedBox(
              height: h * .03,
            ),
            CustomText(
              first: "Faculty",
              second: Faculty,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
            ),
            SizedBox(
              height: h * .03,
            ),
            CustomText(
              first: "Department",
              second: Department.split("+").length > 1
                  ? "${Department.split("+")[0]}..."
                  : Department,
              color: Colors.teal.shade700,
              shadowColor: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
