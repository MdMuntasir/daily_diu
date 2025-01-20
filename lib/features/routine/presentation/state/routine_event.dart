import 'package:flutter/cupertino.dart';

@immutable
sealed class RoutineEvent {
  const RoutineEvent();
}

class RoutineInitialEvent extends RoutineEvent {}

class RoutineLoadingEvent extends RoutineEvent {
  final String department;

  const RoutineLoadingEvent(this.department);
}
