import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/core/controller/boolean_controller.dart';
import 'package:diu_student/features/routine/domain/repository/information_repository.dart';
import 'package:diu_student/features/routine/presentation/pages/blank_routine.dart';
import 'package:diu_student/features/routine/presentation/pages/manual_routine.dart';
import 'package:diu_student/features/routine/presentation/pages/student_routine.dart';
import 'package:diu_student/features/routine/presentation/pages/teacher_routine.dart';
import 'package:diu_student/features/routine/presentation/widgets/custom_button.dart';
import 'package:diu_student/features/routine/presentation/widgets/department_chooser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoutinePage extends StatefulWidget {
  const RoutinePage({super.key});

  @override
  State<RoutinePage> createState() => _RoutinePageState();
}

class _RoutinePageState extends State<RoutinePage> {
  BooleanController studentController = BooleanController();
  BooleanController teacherController = BooleanController();
  BooleanController emptyController   = BooleanController();
  BooleanController manualController  = BooleanController();



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Search Routine",
            style: Theme.of(context).textTheme.displayLarge
          ),
          SizedBox(height: h*.04, width: w,),
          ChooseDepartment(func: (){
            studentController.setValue(hasFunction);
            teacherController.setValue(hasFunction);
            emptyController.setValue(hasFunction);
            manualController.setValue(hasFunction);
            setState(() {});
          },),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentRoutine()));
          },
            tag: "Student",
            text: "Student",
            icon: FontAwesomeIcons.user,
            controller: studentController,),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TeacherRoutine()));
          },
            tag: "Teacher",
            text: "Teacher",
              icon: FontAwesomeIcons.userTie,
            controller: teacherController,),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> EmptySlots()));
          },
            tag: "Empty Slots",
            text: "Empty Slots",
              icon: FontAwesomeIcons.file,
            controller: emptyController,),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ManualRoutine()));
          },
              tag: "Manual",
              text: "Manual",
              icon: FontAwesomeIcons.sliders,
            controller: manualController,),
        ],
      ),
    );
  }
}
