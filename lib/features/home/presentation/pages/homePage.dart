import 'package:diu_student/core/util/widgets/error_screen.dart';
import 'package:diu_student/features/home/presentation/state/home_bloc.dart';
import 'package:diu_student/features/home/presentation/state/home_state.dart';
import 'package:diu_student/features/home/presentation/widgets/bottomBar.dart';
import 'package:diu_student/features/home/presentation/widgets/home_info_show.dart';
import 'package:diu_student/features/home/presentation/widgets/loading_home_screen.dart';
import 'package:diu_student/features/navbar/presentation/pages/NavBar.dart';
import 'package:diu_student/core/util/widgets/showRoutine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/links/api_links.dart';

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

  // Color bottomColor = Colors.teal.shade700;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if (!showOptions) {
      pos = -h * .585;
    } else {
      pos = 0;
    }

    void barFunc() {
      showOptions = !showOptions;
      setState(() {});
    }

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
                  if (details.globalPosition.dy <= h * .42) {
                    showOptions = false;
                  } else if (details.globalPosition.dy >= h * .934 &&
                      details.globalPosition.dy <= h) {
                    showOptions = true;
                  }
                  setState(() {});
                },
                child: Scaffold(
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
                          Text(
                            "DIU Daily",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
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
                          ),
                        ],
                      ),
                    ),
                  ),
                  body: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // ColorFiltered(
                      //   colorFilter: ColorFilter.mode(
                      //     theme.bgShapeColor.withAlpha(150),
                      //     BlendMode.srcATop,
                      //   ),
                      //   child: Image.asset(
                      //     "assets/images/leaf.png",
                      //     fit: BoxFit.cover,
                      //   ),
                      // ),
                      SizedBox(
                        width: w,
                        height: h,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: h * .025,
                            children: [
                              SizedBox(
                                width: w,
                              ),
                              HomeInfoShow(
                                isStudent: isStudent,
                                name: currentUser.name!,
                                faculty: currentUser.faculty!,
                                department: currentUser.department!,
                                teacherInitial: currentUser.ti!,
                                batch: currentUser.batch!,
                                section: currentUser.section!,
                                id: currentUser.studentID!,
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
                        duration: const Duration(milliseconds: 400),
                        child: BottomPanel(
                          controller: !showOptions,
                          function: barFunc,
                        ),
                      )
                    ],
                  ),
                ),
              );

            case LoadingHomeState:
              return const LoadingHomeScreen();

            case HomeFailedState:
              return const Scaffold(
                body: Center(
                  child: ErrorScreen(),
                ),
              );

            default:
              return const Scaffold(
                body: Center(
                  child: ErrorScreen(),
                ),
              );
          }
        });
  }
}
