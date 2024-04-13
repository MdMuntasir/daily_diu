import 'package:diu_student/features/routine/presentation/pages/student_routine.dart';
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
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final departments = {
      'SWE': ['Software Engineering', (){}],
      'CSE': ['Computer Science & Engineering', (){}],
      'ITM': ['Information Technology & Management', (){}],
      'CIS': ['Computing and Information System', (){}],
      'ARCH': ['Architecture', (){}],
      'EEE': ['Electrical and Electronic Engineering', (){}],
      'TE': ['Textile Engineering', (){}],
      'ICE': ['Information and Communication Engineering', (){}],
      'THM': ['Tourism & Hospitality Management', (){}],
      'ACC': ['Accounting', (){}],
      'RE': ['Real Estate', (){}],
      'DBA': ['Business Administration', (){}],
      'DE': ['Innovation & Entrepreneurship', (){}],
      'AGRI': ['Agricultural Science', (){}],
      'PHARM': ['Pharmacy', (){}],
      'NFE': ['Nutrition and Food Engineering', (){}],
      'BPH': ['Public Health', (){}],
      'ESDM': ['Environmental Science and Disaster Management', (){}],
      'PESS': ['Physical Education & Sports Science', (){}],
      'ENG': ['English', (){}],
      'LAW': ['Law', (){}]
    };

    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "Search Routine",
            style: TextStyle(
              fontSize: 50,
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: h*.1, width: w,),
          ChooseDepartment(departments: departments,),
          SizedBox(height: h*.1, width: w,),
          HeroButton(function: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentRoutine()));
          },
            tag: "Student",
            text: "Student",
            icon: FontAwesomeIcons.user,),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){},
            tag: "Teacher",
            text: "Teacher",
              icon: FontAwesomeIcons.userTie),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){},
            tag: "Empty Slots",
            text: "Empty Slots",
              icon: FontAwesomeIcons.file),
          SizedBox(height: h*.05, width: w,),
          HeroButton(function: (){},
              tag: "Manual",
              text: "Manual",
              icon: FontAwesomeIcons.sliders),
        ],
      ),
    );
  }
}
