import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/widgets/download_file.dart';
import 'package:diu_student/core/util/widgets/showRoutine.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/links/api_links.dart';
import '../widgets/search_bar.dart';

class RoutineSearchScreen extends StatefulWidget {
  final String department;
  final bool student;
  final bool deptSelected;
  final List<SlotEntity> allSlots;

  const RoutineSearchScreen({
    super.key,
    required this.department,
    required this.student,
    required this.deptSelected,
    required this.allSlots,
  });

  @override
  State<RoutineSearchScreen> createState() => _RoutineSearchScreenState();
}

class _RoutineSearchScreenState extends State<RoutineSearchScreen> {
  TextEditingController searchController = TextEditingController();
  String title = "";
  bool routineShowed = false, isDownloading = false;
  List<SlotEntity> slots = [];

  //Get the search bar info
  String info() {
    if (widget.student) {
      List<String> batchSection = searchController.text.split("-");
      if (batchSection.length == 2) {
        return batchSection[0] + batchSection[1].toUpperCase();
      } else {
        return "";
      }
    } else {
      return searchController.text.toUpperCase();
    }
  }

  //Search function for teacher
  void teacherSearch() {
    String ti = searchController.text.toUpperCase();
    title = ti;
    slots.clear();
    for (var slot in widget.allSlots) {
      if (slot.ti == ti) {
        slots.add(slot);
      }
    }
    setState(() {
      routineShowed = true;
    });
  }

  //Search function for student
  void sectionSearch() {
    List<String> batchSection = searchController.text.split("-");
    if (batchSection.length == 2) {
      title = "${batchSection[0]}-${batchSection[1].toUpperCase()}";
      slots.clear();
      for (var slot in widget.allSlots) {
        if (slot.batch == batchSection[0] &&
            slot.section![0] == batchSection[1][0].toUpperCase()) {
          slots.add(slot);
        }
      }
      routineShowed = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please follow the example for correct input.")));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: h * .02,
      children: [
        widget.student
            ? CustomSearchBar(
                enable: widget.deptSelected,
                controller: searchController,
                hint: "Enter Section, Ex: 41-N",
                onSearch: sectionSearch,
              )
            : CustomSearchBar(
                enable: widget.deptSelected,
                controller: searchController,
                hint: "Enter Teacher Initial, Ex: IM",
                onSearch: teacherSearch,
              ),
        routineShowed
            ? Container(
                width: w,
                decoration: BoxDecoration(
                    color: Colors.teal.shade700,
                    borderRadius: BorderRadius.circular(w * .02)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: w * .05,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: h * .038,
                            color: Colors.white,
                            fontFamily: "Welcome_Magic"),
                      ),
                      DownloadFile(
                        fileName: info(),
                        url: widget.student
                            ? "$routine_api/${widget.department.toLowerCase()}/routine-pdf/${info()}"
                            : "$routine_api/${widget.department.toLowerCase()}/teacher-pdf/${info()}",
                        context: context,
                      )
                    ],
                  ),
                ),
              )
            : SizedBox(
                height: h * .05,
              ),
        routineShowed
            ? ShowRoutine(
                slots: slots,
                height: 50,
              )
            : Lottie.asset("assets/lottie/Routine.json")
      ],
    );
  }
}
