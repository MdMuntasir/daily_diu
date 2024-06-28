import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/navbar/presentation/pages/NavBar.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_routine.dart';
import 'package:diu_student/features/home/data/models/slot.dart';
import 'package:diu_student/features/home/data/repository/routine_repo_implement.dart';
import 'package:diu_student/features/home/presentation/widgets/customText.dart';
import 'package:diu_student/features/home/presentation/widgets/informationShower.dart';
import 'package:diu_student/features/home/presentation/widgets/showRoutine.dart';
import 'package:diu_student/features/home/presentation/widgets/slotShower.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isNow = false;

  Widget _information = SizedBox();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;




    List timeStamps = [];

    for (var time in test_time[0]["Time"]) {
      List splited = time.toString().split("-");

      List start = [int.parse(splited[0].split(":")[0]),int.parse(splited[0].split(":")[1])],
          end = [int.parse(splited[1].split(":")[0]),int.parse(splited[1].split(":")[1])];

      start[0] = start[0] < 7 ? start[0] + 12 : start[0];
      end[0] = end[0] < 7 ? end[0] + 12 : end[0];

      splited[0] = "${start[0] + start[1]/60}";
      splited[1] = "${end[0] + end[1]/60 - .01}";
      timeStamps.add((
      splited[0],
      splited[1]));
    }




    if(studentInfo.user != null){
      String name = studentInfo.name.toString().split(" ")[0];
      _information = StudentInfoShow(
          Name: name,
          ID: studentInfo.id!,
          Department: studentInfo.department!,
          Batch: studentInfo.batch!,
          Section: studentInfo.section!);
    }


    else {
      String dept = teacherInfo.department.toString().split('-').join("+");
      String name = teacherInfo.name.toString().split(" ")[0];

      _information = TeacherInfoShow(
        Name: name,
        Department: dept,
        Faculty: teacherInfo.faculty!,
        TeacherInitial: teacherInfo.ti!,
      );
    }


    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> NavBar()));
                  },
                  color: Colors.black87,
                  icon: Icon(FontAwesomeIcons.barsStaggered)),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.teal.shade100,
      body: SizedBox(
        width: w,
        height: h,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _information,

              ShowRoutine(slots: MainRoutine,)
            ],
          ),
        ),
      ),
    );
  }
}
