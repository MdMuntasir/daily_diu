import 'package:flutter/cupertino.dart';

import '../../../../core/util/Entities/slot.dart';

@immutable
sealed class RoutineEvent {
  const RoutineEvent();
}

class RoutineInitialEvent extends RoutineEvent {}

class RoutineLoadingEvent extends RoutineEvent {
  final String department;

  const RoutineLoadingEvent(this.department);
}

class SearchRoutineEvent extends RoutineEvent {
  final bool isStudent;
  final String info;
  final List<SlotEntity> slots;

  const SearchRoutineEvent({
    required this.isStudent,
    required this.info,
    required this.slots,
  });
}
