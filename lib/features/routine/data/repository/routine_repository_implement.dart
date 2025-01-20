import 'package:dio/dio.dart';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/model/slot.dart';
import 'package:diu_student/features/routine/data/data_sources/local/local_routine_source.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/data/models/empty_slot_model.dart';
import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';
import 'package:diu_student/features/routine/domain/repository/routine_repository.dart';

class RoutineRepositoryImpl implements RoutineRepository {
  final RoutineApi routineApi;
  final LocalRoutineSource localRoutineSource;
  final ConnectionChecker connectionChecker;

  RoutineRepositoryImpl(
    this.routineApi,
    this.localRoutineSource,
    this.connectionChecker,
  );

  @override
  Future<DataState<List<SlotEntity>>> getAllSlots() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final slots = localRoutineSource.fetchSlots();
        return DataSuccess(slots);
      } else {
        final allSlotData = await routineApi.getSlots();
        if (allSlotData is DataSuccess<List<SlotModel>>) {
          localRoutineSource.uploadSlotData(slots: allSlotData.data!);
          return DataSuccess(allSlotData.data!);
        } else {
          return DataFailed(allSlotData.error.toString());
        }
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<EmptySlotEntity>>> getEmptySlots() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final slots = localRoutineSource.fetchEmptySlots();
        return DataSuccess(slots);
      } else {
        final emptySlots = await routineApi.getEmptySlots();
        if (emptySlots is DataSuccess<List<EmptySlotModel>>) {
          localRoutineSource.uploadEmptySlotData(emptySlots: emptySlots.data!);
          return DataSuccess(emptySlots.data!);
        } else {
          return DataFailed(emptySlots.error.toString());
        }
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List>> getTimes() async {
    try {
      if (!await connectionChecker.isConnected) {
        final times = localRoutineSource.fetchTimes();
        return DataSuccess(times);
      }

      final times = await routineApi.getTimes();
      if (times is DataSuccess<List<dynamic>>) {
        localRoutineSource.uploadTimeData(times: times.data!);
        return DataSuccess(times.data!);
      } else {
        return DataFailed(times.error.toString());
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
