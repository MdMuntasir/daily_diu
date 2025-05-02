import 'package:diu_student/features/home/presentation/widgets/informationShower.dart';
import 'package:flutter/cupertino.dart';

class HomeInfoShow extends StatelessWidget {
  final bool isStudent;
  final String name;
  final String id;
  final String department;
  final String batch;
  final String section;
  final Gradient grad;
  final String faculty;
  final String teacherInitial;

  const HomeInfoShow({
    super.key,
    required this.isStudent,
    required this.name,
    required this.department,
    this.grad = const LinearGradient(colors: [
      Color(0xFF74ebd5),
      Color(0xFFACB6E5),
    ]),
    this.id = "",
    this.batch = "",
    this.section = "",
    this.faculty = "",
    this.teacherInitial = "",
  });

  @override
  Widget build(BuildContext context) {
    return isStudent
        ? StudentInfoShow(
            Name: name,
            ID: id,
            Department: department,
            Batch: batch,
            Section: section,
          )
        : TeacherInfoShow(
            Name: name,
            Department: department,
            Faculty: faculty,
            TeacherInitial: teacherInitial,
            grad: grad,
          );
  }
}
