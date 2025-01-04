import 'dart:developer';

import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/core/util/widgets/showRoutine.dart';
import 'package:flutter/cupertino.dart';
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
  bool routineShowed = false;
  List<SlotModel> slots = [];


  void teacherSearch(){
    String ti = searchController.text.toUpperCase();
    slots.clear();
    allSlots.forEach((slot){
      if(slot.ti == ti){
        slots.add(slot);
      }
    });
    setState(() {routineShowed = true;});
  }


  void sectionSearch(){
    List<String> batchSection = searchController.text.split("-");
    if(batchSection.length == 2){
      slots.clear();
      allSlots.forEach((slot){
        if(slot.batch == batchSection[0] && slot.section == batchSection[1].toUpperCase()){
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


        SizedBox(height: h*.05,),

        routineShowed?
        ShowRoutine(slots: slots)  :
        Lottie.asset("assets/lottie/Routine.json")
      ],
    );
  }
}
