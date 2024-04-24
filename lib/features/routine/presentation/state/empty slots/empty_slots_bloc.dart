import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/domain/usecases/empty%20slot/empty_slot_usercase.dart';
import 'package:diu_student/features/routine/presentation/state/empty%20slots/empty_slots_event.dart';
import 'package:diu_student/features/routine/presentation/state/empty%20slots/empty_slots_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmptySlotBloc extends Bloc<EmptySlotsEvent,EmptySlotState> {
  final GetEmptySlotUseCase _emptySlotUseCase;

  EmptySlotBloc(this._emptySlotUseCase) : super(EmptySlotLoading()) {
    on<getEmptySlots> (onGetEmptySlots);
  }

  Future<void> onGetEmptySlots(getEmptySlots event,
      Emitter<EmptySlotState> emit) async {
    final dataState = await _emptySlotUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
          EmptySlotDone(dataState.data!)
      );
    }
    else if (dataState is DataFailed) {
      emit(
          EmptySlotError(dataState.error!)
      );
    }
  }
}