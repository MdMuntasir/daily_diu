import 'dart:developer';

import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/core/util/widgets/showRoutine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/util/model/slot.dart';
import '../widgets/search_bar.dart';

class RoutineSearchScreen extends StatefulWidget {
  final bool student;
  final bool deptSelected;
  const RoutineSearchScreen({super.key, required this.student, required this.deptSelected});

  @override
  State<RoutineSearchScreen> createState() => _RoutineSearchScreenState();
}

class _RoutineSearchScreenState extends State<RoutineSearchScreen> {
  TextEditingController searchController = TextEditingController();
  String title = "";
  bool routineShowed = false;
  List<SlotModel> slots = [];



  //Search function for teacher
  void teacherSearch(){
    String ti = searchController.text.toUpperCase();
    title = ti;
    slots.clear();
    allSlots.forEach((slot){
      if(slot.ti == ti){
        slots.add(slot);
      }
    });
    setState(() {routineShowed = true;});
  }



  //Search function for student
  void sectionSearch(){
    List<String> batchSection = searchController.text.split("-");
    if(batchSection.length == 2){
      title = batchSection[0] + "-" + batchSection[1].toUpperCase();
      slots.clear();
      allSlots.forEach((slot){
        if(slot.batch == batchSection[0] && slot.section![0] == batchSection[1][0].toUpperCase()){
          slots.add(slot);
        }
      });
    }

    else{
      log("Enter Batch and Section properly, ex: 41-N");
    }

    setState(() {routineShowed = true;});
  }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: h*.02,
      children: [
        widget.student?
        CustomSearchBar(
          enable: widget.deptSelected,
          controller: searchController,
          hint: "Enter Section, Ex: 41-N",
          onSearch: sectionSearch,
        )
        :
        CustomSearchBar(
          enable: widget.deptSelected,
          controller: searchController,
          hint: "Enter Teacher Initial, Ex: IM",
          onSearch: teacherSearch,
        ),


        routineShowed?
        Container(
          width: w,
          decoration: BoxDecoration(
            color: Colors.teal.shade700
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w*.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: w*.05,),


                Text(
                  title,
                  style: TextStyle(
                    fontSize: h*.038,
                    color: Colors.white,
                    fontFamily: "Welcome_Magic"
                  ),
                ),


                IconButton(

                  // style: const ButtonStyle(
                  //   backgroundColor: WidgetStatePropertyAll(Colors.white)
                  // ),
                    onPressed: (){},
                    icon: Icon(FontAwesomeIcons.download,color: Colors.white,size: w*.04)),
              ],
            ),
          ),
        )
            : SizedBox(height: h*.05,),

        routineShowed?
        ShowRoutine(slots: slots, height: 50,)  :
        Lottie.asset("assets/lottie/Routine.json")
      ],
    );
  }
}
