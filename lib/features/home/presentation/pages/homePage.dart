import 'dart:ui';
import 'package:diu_student/core/util/widgets/error_screen.dart';
import 'package:diu_student/features/home/presentation/state/home_bloc.dart';
import 'package:diu_student/features/home/presentation/state/home_event.dart';
import 'package:diu_student/features/home/presentation/state/home_state.dart';
import 'package:diu_student/features/home/presentation/widgets/bottomBar.dart';
import 'package:diu_student/features/home/presentation/widgets/home_info_show.dart';
import 'package:diu_student/features/navbar/presentation/pages/NavBar.dart';
import 'package:diu_student/core/util/widgets/showRoutine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/constants.dart';

import '../../../../core/util/widgets/download_file.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isNow = false, showOptions = false;

  // final bool isStudent = studentInfo.user != "";
  bool isDownloading = false;

  double pos = 0, prog = 0;

  Radius left = Radius.zero, right = Radius.zero;
  Widget _information = SizedBox();

  Gradient lightGrad1 = const LinearGradient(colors: [
    Color(0xFF74ebd5),
    Color(0xFFACB6E5),
  ]);
  Color bottomColor = Color(0xFFB6EADA);

  // Color bottomColor = Colors.teal.shade700;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if (!showOptions) {
      bottomColor = Colors.teal.shade400;
      pos = -h * .585;
      left = Radius.elliptical(w, h * .2);
      right = Radius.elliptical(w, h * .2);
    } else {
      bottomColor = Color(0xFFB6EADA);
      pos = 0;
      left = Radius.circular(w * .2);
      right = Radius.circular(w * .2);
    }

    void barFunc() {
      showOptions = !showOptions;
      setState(() {});
    }

    // Future<void> _downloadRoutine() async {
    //   bool RequestAccepted;
    //
    //   final _checkConnection = await Connectivity().checkConnectivity();
    //   bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) ||
    //       _checkConnection.contains(ConnectivityResult.wifi);
    //
    //   if (android_info.version.sdkInt <= 32) {
    //     RequestAccepted = await Permission.storage.request().isGranted;
    //   } else {
    //     RequestAccepted = await Permission.photos.request().isGranted;
    //   }
    //
    //   String info = isStudent
    //       ? "${studentInfo.batch!}${studentInfo.section!}"
    //       : "${teacherInfo.ti}";
    //
    //   if (RequestAccepted) {
    //     if (isConnected) {
    //       setState(() {
    //         isDownloading = true;
    //       });
    //
    //       await Services().DownloadFile(
    //           url: isStudent
    //               ? "$routine_api/${studentInfo.department}/routine-pdf/$info"
    //               : "$routine_api/${teacherInfo.department}/full-teacher-pdf/$info",
    //           filename: info, (path) {
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(SnackBar(content: Text(path)));
    //       }, onDownloadError: () {
    //         ScaffoldMessenger.of(context)
    //             .showSnackBar(const SnackBar(content: Text("Download failed")));
    //       });
    //
    //       setState(() {
    //         isDownloading = false;
    //       });
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //           const SnackBar(content: Text("No Internet Connection")));
    //     }
    //   }
    // }

    // if (studentInfo.user != null) {
    //   String name = studentInfo.name.toString().split(" ")[0];
    //   _information = StudentInfoShow(
    //     Name: name,
    //     ID: studentInfo.studentID!,
    //     Department: studentInfo.department!,
    //     Batch: studentInfo.batch!,
    //     Section: studentInfo.section!,
    //     grad: lightGrad1,
    //   );
    // } else {
    //   String dept = teacherInfo.department.toString().split('-').join("+");
    //   String name = teacherInfo.name.toString().split(" ")[0];
    //
    //   _information = TeacherInfoShow(
    //     Name: name,
    //     Department: dept,
    //     Faculty: teacherInfo.faculty!,
    //     TeacherInitial: teacherInfo.ti!,
    //     grad: lightGrad1,
    //   );
    // }

    // print(MainRoutine);

    return BlocConsumer(
        bloc: context.read<HomeBloc>(),
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case HomeSuccessState:
              final successState = state as HomeSuccessState;
              final currentUser = successState.user;
              final isStudent = currentUser.user == "Student";

              return GestureDetector(
                onVerticalDragDown: (details) {
                  if (details.globalPosition.dy <= h * .42)
                    showOptions = false;
                  else if (details.globalPosition.dy >= h * .934 &&
                      details.globalPosition.dy <= h) showOptions = true;
                  setState(() {});
                },
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    toolbarHeight: h * .05,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const NavBar()));
                              },
                              color: Colors.black87,
                              icon: const Icon(FontAwesomeIcons.barsStaggered)),

                          DownloadFile(
                            fileName: isStudent
                                ? "${currentUser.batch}${currentUser.section}"
                                : currentUser.ti!.toUpperCase(),
                            url: isStudent
                                ? "$routine_api/${currentUser.department!.toLowerCase()}/routine-pdf/${currentUser.batch}${currentUser.section}"
                                : "$routine_api/${currentUser.department!.toLowerCase()}/full-teacher-pdf/${currentUser.ti}",
                            color: Colors.black87,
                            blackDownloading: true,
                            context: context,
                          )

                          // isDownloading
                          //     ? Padding(
                          //         padding: EdgeInsets.only(right: w * .03),
                          //         child: Lottie.asset(
                          //             "assets/lottie/Download.json",
                          //             height: w * .052,
                          //             width: w * .055),
                          //       )
                          //     : IconButton(
                          //         onPressed: _downloadRoutine,
                          //         icon: Icon(
                          //           Icons.file_download_outlined,
                          //           size: w * .07,
                          //         ))
                        ],
                      ),
                    ),
                  ),
                  backgroundColor: Colors.teal.shade100,
                  body: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        width: w,
                        height: h,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              HomeInfoShow(
                                isStudent: isStudent,
                                name: currentUser.name!.split(" ")[0],
                                faculty: currentUser.faculty!,
                                department: currentUser.department!,
                                teacherInitial: currentUser.ti!,
                                batch: currentUser.batch!,
                                section: currentUser.section!,
                                id: currentUser.studentID!,
                                grad: lightGrad1,
                              ),
                              ShowRoutine(
                                slots: successState.routine,
                              )
                            ],
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        bottom: pos,
                        duration: Duration(milliseconds: 500),
                        child: BottomPanel(
                            color: bottomColor,
                            controller: !showOptions,
                            left: left,
                            right: right,
                            IconfgColor: bottomColor,
                            function: barFunc),
                      )
                    ],
                  ),
                ),
              );

            case LoadingHomeState:
              return const Center(
                child: CupertinoActivityIndicator(),
              );

            case HomeFailedState:
              return const Center(
                child: ErrorScreen(),
              );

            default:
              return const Center(
                child: ErrorScreen(),
              );
          }
        });
  }
}
