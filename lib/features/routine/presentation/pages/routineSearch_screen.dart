import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/core/util/widgets/showRoutine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants&variables/constants.dart';
import '../../../../core/util/model/slot.dart';
import '../../../../core/util/services.dart';
import '../widgets/search_bar.dart';

class RoutineSearchScreen extends StatefulWidget {
  final bool student;
  final bool deptSelected;

  const RoutineSearchScreen(
      {super.key, required this.student, required this.deptSelected});

  @override
  State<RoutineSearchScreen> createState() => _RoutineSearchScreenState();
}

class _RoutineSearchScreenState extends State<RoutineSearchScreen> {
  TextEditingController searchController = TextEditingController();
  String title = "";
  bool routineShowed = false, isDownloading = false;
  List<SlotModel> slots = [];

  //Function to download routine
  Future<void> _downloadRoutine() async {
    bool RequestAccepted;
    bool error = false;

    final _checkConnection = await Connectivity().checkConnectivity();
    bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) ||
        _checkConnection.contains(ConnectivityResult.wifi);

    if (android_info.version.sdkInt <= 32) {
      RequestAccepted = await Permission.storage.request().isGranted;
    } else {
      RequestAccepted = await Permission.photos.request().isGranted;
    }

    String info = "";

    if (widget.student) {
      List<String> batchSection = searchController.text.split("-");
      if (batchSection.length == 2) {
        info = batchSection[0] + batchSection[1].toUpperCase();
      } else {
        error = true;
      }
    } else {
      info = searchController.text.toUpperCase();
    }

    if (RequestAccepted && !error) {
      if (isConnected) {
        setState(() {
          isDownloading = true;
        });

        await Services().DownloadFile(
            url: widget.student
                ? "$routine_api/$selectedDepartment/routine-pdf/$info"
                : "$routine_api/$selectedDepartment/teacher-pdf/$info",
            filename: info, (path) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(path)));
        }, onDownloadError: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Download failed")));
        });

        setState(() {
          isDownloading = false;
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No Internet Connection")));
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please follow the example for correct input.")));
      }
    }
  }

  //Search function for teacher
  void teacherSearch() {
    String ti = searchController.text.toUpperCase();
    title = ti;
    slots.clear();
    allSlots.forEach((slot) {
      if (slot.ti == ti) {
        slots.add(slot);
      }
    });
    setState(() {
      routineShowed = true;
    });
  }

  //Search function for student
  void sectionSearch() {
    List<String> batchSection = searchController.text.split("-");
    if (batchSection.length == 2) {
      title = batchSection[0] + "-" + batchSection[1].toUpperCase();
      slots.clear();
      allSlots.forEach((slot) {
        if (slot.batch == batchSection[0] &&
            slot.section![0] == batchSection[1][0].toUpperCase()) {
          slots.add(slot);
        }
      });
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
                      isDownloading
                          ? Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: w * .03),
                              child: Lottie.asset("assets/lottie/Download.json",
                                  height: w * .053, width: w * .055),
                            )
                          : IconButton(
                              onPressed: _downloadRoutine,
                              icon: Icon(Icons.file_download_outlined,
                                  color: Colors.white, size: w * .07)),
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
            // : Lottie.asset("assets/lottie/Routine.json")
            : SizedBox()
      ],
    );
  }
}
