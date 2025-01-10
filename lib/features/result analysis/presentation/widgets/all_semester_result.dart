import 'package:diu_student/features/result%20analysis/presentation/widgets/semster_result.dart';
import 'package:flutter/cupertino.dart';

import '../../data/model/semesterResultModel.dart';

class AllSemesterResult extends StatelessWidget {
  final double height;
  final double width;
  final List<List<SemesterResultModel>> results;

  const AllSemesterResult(
      {super.key,
      required this.height,
      required this.width,
      required this.results});

  @override
  Widget build(BuildContext context) {
    List<SemesterResult> semesterResults() {
      List<SemesterResult> temp = [];
      for (List<SemesterResultModel> semester in results) {
        temp.add(SemesterResult(
          gpa: semester[0].cgpa,
          semester: semester[0].semesterName + semester[0].semesterYear,
        ));
      }
      return temp;
    }

    return SizedBox(
      height: height,
      child: SingleChildScrollView(
        child: Wrap(
          spacing: width * .08,
          runSpacing: width * .08,
          children: semesterResults(),
        ),
      ),
    );
  }
}
