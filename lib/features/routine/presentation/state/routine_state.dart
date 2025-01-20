import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class RoutineState {
  const RoutineState();
}

sealed class RoutineActionState extends RoutineState {}

class RoutineInitial extends RoutineState {}

class RoutineLoading extends RoutineState {}

class RoutineSuccess extends RoutineState {
  final String department;
  final List<SlotEntity> slots;
  final List<EmptySlotEntity> emptySlots;
  final List times;

  const RoutineSuccess(
    this.slots,
    this.emptySlots,
    this.times,
    this.department,
  );
}

class RoutineEmptyState extends RoutineState {}

class RoutineFailed extends RoutineState {
  final String errorMessage;

  const RoutineFailed(this.errorMessage);
}

class SearchRoutine extends RoutineActionState {}
