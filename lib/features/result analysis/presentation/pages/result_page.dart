import 'package:diu_student/core/util/widgets/error_screen.dart';
import 'package:diu_student/features/result%20analysis/presentation/state/result_bloc.dart';
import 'package:diu_student/features/result%20analysis/presentation/state/result_event.dart';
import 'package:diu_student/features/result%20analysis/presentation/state/result_state.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/all_semester_result.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/cgpa_bar.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/display_cgpa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../navbar/presentation/pages/NavBar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool cgpaShow = false;

  @override
  void initState() {
    context.read<ResultBloc>().add(ResultInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Hero(
          tag: "Result",
          child: Text(
            "Result",
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
                      context
                          .read<ResultBloc>()
                          .add(ResultNavigateToNavBarEvent());
                    },
                    color: Colors.teal.shade900,
                    icon: const Icon(FontAwesomeIcons.barsStaggered)),
              ],
            ),
          )
        ],
      ),
      body: BlocConsumer(
        bloc: context.read<ResultBloc>(),
        listenWhen: (prev, current) => current is ResultActionState,
        buildWhen: (prev, current) =>
            current is! ResultActionState || current is ResultFailureState,
        listener: (context, state) {
          if (state is ResultNavigateToNavBarActionState) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NavBar()));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case ResultLoadingState:
              return Center(
                child: Lottie.asset(
                  "assets/lottie/Loading1.json",
                  height: h * .3,
                ),
              );

            case ResultSuccessState:
              final successState = state as ResultSuccessState;
              final results = successState.results.reversed.toList();

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: h * .03,
                  children: [
                    DisplayCgpa(
                      showAvg: cgpaShow,
                      results: results,
                      cgpa: successState.cgpa,
                    ),
                    CgpaBar(
                      cgpa: successState.cgpa,
                      avgShow: cgpaShow,
                      func: () {
                        setState(() {
                          cgpaShow = !cgpaShow;
                        });
                      },
                    ),
                    AllSemesterResult(
                      height: h * .35,
                      width: w,
                      results: successState.results,
                      mainContext: context,
                    )
                  ],
                ),
              );

            case ResultFailureState:
              final failureState = state as ResultFailureState;
              return ErrorScreen(
                onPressed: () {
                  context.read<ResultBloc>().add(ResultInitialEvent());
                },
                message: failureState.errorMessage,
              );

            case ResultEmptyState:
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
                        "No data found. You may be a fresher, or the ID in your profile seems incorrect.",
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

            default:
              return ErrorScreen(
                onPressed: () {
                  context.read<ResultBloc>().add(ResultInitialEvent());
                  setState(() {});
                },
              );
          }
        },
      ),
    );
  }
}
