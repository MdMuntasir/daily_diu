import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoShow extends StatelessWidget {
  final UserEntity user;

  const UserInfoShow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h > w;
    double round = 20;

    bool isStudent = user.user == "Student";
    String Department = user.department!;

    Row _row(String title, String sub) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title : ",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: "Madimi"),
          ),
          Text(
            sub,
            style: const TextStyle(
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
                style: const TextStyle(
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
                  style: const TextStyle(
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
                style: const TextStyle(
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
                  style: const TextStyle(
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
        width: horizontal ? w * .9 : h * .9,
        height: horizontal
            ? isStudent
                ? h * .38
                : h * .33
            : w * .38,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(round)),
            color: Colors.teal.shade50,
            boxShadow: [
              BoxShadow(blurRadius: 20, spreadRadius: -10, offset: Offset(2, 5))
            ]),
        child: Padding(
          padding: horizontal
              ? EdgeInsets.symmetric(horizontal: w * .1, vertical: h * .04)
              : EdgeInsets.symmetric(horizontal: h * .1, vertical: w * .04),
          child: _information,
        ));
  }
}
