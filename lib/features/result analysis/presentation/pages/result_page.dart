import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/all_semester_result.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/cgpa_bar.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/display_cgpa.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/semster_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../navbar/presentation/pages/NavBar.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool cgpaShow = false;
  final results = resultTest;

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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => NavBar()));
                    },
                    color: Colors.teal.shade900,
                    icon: Icon(FontAwesomeIcons.barsStaggered)),
              ],
            ),
          )
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: h * .03,
        children: [
          DisplayCgpa(
            showAvg: cgpaShow,
            results: results,
            cgpa: 3.9,
          ),
          CgpaBar(
            cgpa: 3.9,
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
            results: results,
          )
        ],
      ),
    );
  }
}
