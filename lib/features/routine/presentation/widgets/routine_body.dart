import 'package:flutter/cupertino.dart';

import '../pages/blank_routine.dart';
import '../pages/manual_routine.dart';
import '../pages/routineSearch_screen.dart';

class RoutineBody extends StatefulWidget {
  final String option;

  const RoutineBody({super.key, required this.option});

  @override
  State<RoutineBody> createState() => _RoutineBodyState();
}

class _RoutineBodyState extends State<RoutineBody> {
  @override
  Widget build(BuildContext context) {
    switch (widget.option) {
      case "Student":
        return const RoutineSearchScreen(student: true, deptSelected: true);

      case "Teacher":
        return const RoutineSearchScreen(student: false, deptSelected: true);

      case "Empty Slot":
        return const EmptySlots();

      case "Manual Search":
        return const ManualRoutine();

      default:
        return const RoutineSearchScreen(student: true, deptSelected: false);
    }
  }
}
