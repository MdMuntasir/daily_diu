import 'package:diu_student/config/theme/custom%20themes/navbar_theme.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/material.dart';

class UserInfoShow extends StatelessWidget {
  final UserEntity user;

  const UserInfoShow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).extension<NavbarTheme>()!;
    double round = 18;

    bool isStudent = user.user == "Student";
    String Department = user.department!;

    Row _row(String title, String sub) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title : ",
            style: TextStyle(
                color: theme.fgColor,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: "Madimi"),
          ),
          Text(
            sub,
            style: TextStyle(
                color: theme.fgColor,
                fontWeight: FontWeight.w400,
                fontSize: 16,
                fontFamily: "Madimi"),
          ),
        ],
      );
    }

    Widget _information = isStudent
        ? Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                user.name!,
                style: TextStyle(
                    color: theme.fgColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Madimi"),
                textAlign: TextAlign.center,
              ),
              _row("Email", ""),
              SizedBox(
                width: w,
                child: Text(
                  user.email!,
                  style: TextStyle(
                      color: theme.fgColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Madimi"),
                  textAlign: TextAlign.start,
                ),
              ),
              _row("Student ID", user.studentID!),
              _row("Faculty", user.faculty!),
              _row("Department", user.department!),
              _row("Section", "${user.batch!}-${user.section!}"),
            ],
          )
        : Column(
            children: [
              Text(
                user.name!,
                style: TextStyle(
                    color: theme.fgColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    fontFamily: "Madimi"),
                textAlign: TextAlign.center,
              ),
              _row("Email", ""),
              SizedBox(
                width: w,
                child: Text(
                  user.email!,
                  style: TextStyle(
                      color: theme.fgColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      fontFamily: "Madimi"),
                  textAlign: TextAlign.start,
                ),
              ),
              _row("Teacher Initial", user.ti!),
              _row("Faculty", user.faculty!),
              _row(
                  "Department",
                  Department.split("-").length > 1
                      ? "${Department.split("-")[0]}..."
                      : Department),
            ],
          );

    return Container(
        width: w * .9,
        height: isStudent ? h * .38 : h * .33,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(round)),
            color: theme.bgColor,
            boxShadow: const [
              BoxShadow(blurRadius: 20, spreadRadius: -10, offset: Offset(2, 5))
            ]),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * .1, vertical: h * .04),
          child: _information,
        ));
  }
}
