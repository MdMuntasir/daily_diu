import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/model/slot.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/util/widgets/showRoutine.dart';
import 'bottomBar.dart';
import 'home_info_show.dart';

class LoadingHomeScreen extends StatefulWidget {
  const LoadingHomeScreen({super.key});

  @override
  State<LoadingHomeScreen> createState() => _LoadingHomeScreenState();
}

class _LoadingHomeScreenState extends State<LoadingHomeScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Skeletonizer(
          effect:
              ShimmerEffect.raw(colors: [Colors.white, Colors.teal.shade100]),
          enabled: true,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              SizedBox(
                width: w,
                height: h,
                child: const SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      HomeInfoShow(
                        isStudent: true,
                        name: "UserName",
                        faculty: "Faculty",
                        department: "Department",
                        teacherInitial: "TI",
                        batch: "Batch",
                        section: "Section",
                        id: "StudentID",
                      ),
                      ShowRoutine(
                        slots: [
                          SlotModel(
                            dept: "",
                            room: "",
                            time: "Time",
                            batch: "",
                            section: "",
                            course: "",
                            ti: "",
                            day: "",
                          ),
                          SlotModel(
                            dept: "",
                            room: "",
                            time: "Time",
                            batch: "",
                            section: "",
                            course: "",
                            ti: "",
                            day: "",
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: -h * .585,
                duration: const Duration(milliseconds: 400),
                child: BottomPanel(
                    color: const Color(0xFFB6EADA),
                    controller: false,
                    left: Radius.elliptical(w, h * .2),
                    right: Radius.elliptical(w, h * .2),
                    IconfgColor: Colors.white,
                    function: () {}),
              )
            ],
          )),
    );
  }
}
