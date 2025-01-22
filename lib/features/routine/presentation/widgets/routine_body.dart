import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';
import 'package:flutter/cupertino.dart';

import '../pages/blank_routine.dart';
import '../pages/manual_routine.dart';
import '../pages/routineSearch_screen.dart';

class RoutineBody extends StatefulWidget {
  final String option;
  final String department;
  final List<SlotEntity> allSlots;
  final List<EmptySlotEntity> emptySlots;
  final List times;

  const RoutineBody(
      {super.key,
      required this.option,
      required this.allSlots,
      required this.emptySlots,
      required this.times,
      required this.department});

  @override
  State<RoutineBody> createState() => _RoutineBodyState();
}

class _RoutineBodyState extends State<RoutineBody> {
  @override
  Widget build(BuildContext context) {
    switch (widget.option) {
      case "Student":
        return RoutineSearchScreen(
          student: true,
          deptSelected: true,
          allSlots: widget.allSlots,
          department: widget.department,
        );

      case "Teacher":
        return RoutineSearchScreen(
          student: false,
          deptSelected: true,
          allSlots: widget.allSlots,
          department: widget.department,
        );

      case "Empty Slot":
        return EmptySlots(
          times: widget.times,
          emptySlots: widget.emptySlots,
        );

      case "Manual Search":
        return ManualRoutine(
          allSlots: widget.allSlots,
          times: widget.times,
        );

      default:
        return const RoutineSearchScreen(
          student: true,
          deptSelected: false,
          allSlots: [],
          department: "",
        );
    }
  }
}
