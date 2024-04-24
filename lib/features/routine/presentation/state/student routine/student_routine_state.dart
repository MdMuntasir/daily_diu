import 'package:dio/dio.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/slot.dart';
import '../../../domain/entities/time.dart';

abstract class StudentRoutineState extends Equatable{
  final List<SlotModel> ? slots;
  final DioException ? exception;

  StudentRoutineState({this.slots, this.exception});

  @override
  List<Object> get props => [slots!,exception!];
}


class StudentRoutineLoading extends StudentRoutineState{
  StudentRoutineLoading();
}

class StudentRoutineDone extends StudentRoutineState{
  StudentRoutineDone(List<SlotModel> slot) : super(slots: slot);
}

class StudentRoutineError extends StudentRoutineState{
  StudentRoutineError(DioException exception) : super(exception: exception);
}


abstract class TimeState extends Equatable{
  final List<TimeEntity> ? times;
  final DioException ? exception;

  TimeState({this.times, this.exception});

  @override
  List<Object> get props => [times!,exception!];
}


class TimeStateLoading extends TimeState{
  TimeStateLoading();
}

class TimeStateDone extends TimeState{
  TimeStateDone(List<TimeEntity> times) : super(times: times);
}

class TimeStateError extends TimeState{
  TimeStateError(DioException exception) : super(exception: exception);
}