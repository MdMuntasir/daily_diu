import 'dart:async';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/data_sources/local/local_routine_source.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/data/repository/routine_repository_implement.dart';
import 'package:diu_student/features/routine/domain/repository/routine_repository.dart';
import 'package:diu_student/features/routine/domain/usecases/all_slot_usecase.dart';
import 'package:diu_student/features/routine/domain/usecases/empty_slot_usecase.dart';
import 'package:diu_student/features/routine/domain/usecases/time_usecase.dart';
import 'package:diu_student/features/routine/presentation/state/routine_event.dart';
import 'package:diu_student/features/routine/presentation/state/routine_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class RoutineBloc extends Bloc<RoutineEvent, RoutineState> {
  RoutineBloc() : super(RoutineInitial()) {
    on<RoutineInitialEvent>(routineInitialEvent);

    on<RoutineLoadingEvent>(routineLoadingEvent);
  }

  FutureOr<void> routineInitialEvent(
    RoutineInitialEvent event,
    Emitter<RoutineState> emit,
  ) {
    emit(RoutineInitial());
  }

  FutureOr<void> routineLoadingEvent(
    RoutineLoadingEvent event,
    Emitter<RoutineState> emit,
  ) async {
    emit(RoutineLoading());
    final RoutineRepository routineRepositoryImpl = RoutineRepositoryImpl(
      RoutineApiImpl(event.department),
      LocalRoutineSourceImpl(Hive.box("Routine"), event.department),
      ConnectionCheckerImpl(InternetConnection.createInstance()),
    );
    final slots = await GetAllSlotUseCase(routineRepositoryImpl).call();
    final emptySlots = await GetEmptySlotUseCase(routineRepositoryImpl).call();
    final times = await GetTimeUseCase(routineRepositoryImpl).call();

    if (slots is DataFailed ||
        emptySlots is DataFailed ||
        times is DataFailed) {
      emit(const RoutineFailed("Oops!!! Something Went Wrong"));
    } else {
      if (slots.data!.isEmpty ||
          emptySlots.data!.isEmpty ||
          times.data!.isEmpty) {
        emit(RoutineEmptyState());
      } else {
        emit(RoutineSuccess(slots.data!, emptySlots.data!, times.data!,
            event.department.toUpperCase()));
      }
    }
  }
}
