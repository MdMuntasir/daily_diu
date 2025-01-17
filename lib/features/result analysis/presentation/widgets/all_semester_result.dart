import 'package:diu_student/features/result%20analysis/presentation/pages/semester_result_page.dart';
import 'package:diu_student/features/result%20analysis/presentation/widgets/semster_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/semesterResultEntity.dart';

class AllSemesterResult extends StatelessWidget {
  final double height;
  final double width;
  final BuildContext mainContext;
  final List<List<SemesterResultEntity>> results;

  const AllSemesterResult(
      {super.key,
      required this.height,
      required this.width,
      required this.results,
      required this.mainContext});

  @override
  Widget build(BuildContext context) {
    List<SemesterResult> semesterResults() {
      List<SemesterResult> temp = [];
      for (List<SemesterResultEntity> semester in results) {
        temp.add(SemesterResult(
          gpa: semester[0].cgpa.toDouble(),
          semester:
              "${semester[0].semesterName} ${semester[0].semesterYear.toString()}",
          onTap: () {
            Navigator.of(mainContext).push(MaterialPageRoute(
                builder: (context) => SemesterResultPage(result: semester)));
          },
        ));
      }
      return temp;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: SizedBox(
        height: height,
        child: SingleChildScrollView(
          child: Wrap(
            spacing: width * .08,
            runSpacing: width * .08,
            children: semesterResults(),
          ),
        ),
      ),
    );
  }
}
