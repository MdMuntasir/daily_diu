import 'package:diu_student/core/util/widgets/error_screen.dart';
import 'package:diu_student/features/routine/presentation/state/routine_bloc.dart';
import 'package:diu_student/features/routine/presentation/state/routine_event.dart';
import 'package:diu_student/features/routine/presentation/state/routine_state.dart';
import 'package:diu_student/features/routine/presentation/widgets/option_chooser.dart';
import 'package:diu_student/features/routine/presentation/widgets/routine_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/controller/boolean_controller.dart';
import 'package:diu_student/features/routine/presentation/widgets/department_chooser.dart';
import '../../../navbar/presentation/pages/NavBar.dart';

class MainRoutinePage extends StatefulWidget {
  const MainRoutinePage({super.key});

  @override
  State<MainRoutinePage> createState() => _MainRoutinePageState();
}

class _MainRoutinePageState extends State<MainRoutinePage> {
  BooleanController studentController = BooleanController();
  BooleanController teacherController = BooleanController();
  BooleanController emptyController = BooleanController();
  BooleanController manualController = BooleanController();

  TextEditingController optionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  final options = ["Student", "Teacher", "Empty Slot", "Manual Search"];

  @override
  void initState() {
    context.read<RoutineBloc>().add(RoutineInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    optionController.dispose();
    searchController.dispose();

    super.dispose();
  }

  bool deptSelected = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Hero(
              tag: "Routine",
              child: Text(
                "Routine",
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * .05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NavBar()));
                        },
                        color: Colors.teal.shade900,
                        icon: const Icon(FontAwesomeIcons.barsStaggered)),
                  ],
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: h * .02,
              children: [
                SizedBox(
                  width: w,
                ),
                //Buttons on the upper section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const ChooseDepartment(),
                    OptionChooser(
                      enable:
                          context.read<RoutineBloc>().state is RoutineSuccess,
                      list: options,
                      controller: optionController,
                      onChoose: () {
                        setState(() {});
                      },
                    )
                  ],
                ),

                BlocConsumer(
                  bloc: context.read<RoutineBloc>(),
                  listener: (context, state) {
                    if (state is! RoutineLoading) {
                      setState(() {});
                    }
                  },
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case RoutineSuccess:
                        final successState = state as RoutineSuccess;
                        return RoutineBody(
                          option: optionController.text == ""
                              ? "Student"
                              : optionController.text,
                          allSlots: successState.slots,
                          emptySlots: successState.emptySlots,
                          times: successState.times,
                          department: successState.department,
                        );

                      case RoutineEmptyState:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: h * .02,
                          children: [
                            Lottie.asset(
                              "assets/lottie/DataError.json",
                              width: w * .6,
                              height: w * .6,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: w,
                            ),
                            SizedBox(
                              width: w * .6,
                              child: Center(
                                child: Text(
                                  "Routine not available. Please check your internet connection and try again.",
                                  style: TextStyle(
                                    color: Colors.teal.shade900,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );

                      case RoutineFailed:
                        return const ErrorScreen();

                      default:
                        return RoutineBody(
                          option: optionController.text,
                          allSlots: [],
                          emptySlots: [],
                          times: [],
                          department: "",
                        );
                    }
                  },
                ),
              ],
            ),
          )),
    );
  }
}
