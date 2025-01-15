import 'package:diu_student/features/result%20analysis/presentation/widgets/single_course_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/semesterResultEntity.dart';

class SemesterResultPage extends StatefulWidget {
  final List<SemesterResultEntity> result;

  const SemesterResultPage({
    super.key,
    required this.result,
  });

  @override
  State<SemesterResultPage> createState() => _SemesterResultPageState();
}

class _SemesterResultPageState extends State<SemesterResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.result[0].semesterName} ${widget.result[0].semesterYear.toString()}",
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
      body: ListView.builder(
        itemCount: widget.result.length,
        itemBuilder: (context, index) {
          return SingleCourseResult(result: widget.result[index]);
        },
      ),
    );
  }
}
