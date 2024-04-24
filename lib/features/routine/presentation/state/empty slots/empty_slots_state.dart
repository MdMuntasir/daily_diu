import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/empty_slot.dart';

abstract class EmptySlotState extends Equatable{
  final List<EmptySlotEntity> ? slots;
  final DioException ? exception;

  EmptySlotState({this.slots,this.exception});

  @override
  List<Object> get props => [slots!,exception!];

}


class EmptySlotLoading extends EmptySlotState{
  EmptySlotLoading();
}

class EmptySlotDone extends EmptySlotState{
  EmptySlotDone(List<EmptySlotEntity> slot) : super(slots: slot);
}

class EmptySlotError extends EmptySlotState{
  EmptySlotError(DioException exception) : super(exception: exception);
}