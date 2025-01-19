import 'package:dio/dio.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/models/time.dart';
import '../../../../../core/constants&variables/constants.dart';
import '../../../../../core/util/model/slot.dart';
import '../../models/empty_slot_model.dart';

final dio = Dio();

abstract class RoutineApi {
  Future<DataState<List<SlotModel>>> getSlots();

  Future<DataState<List<EmptySlotModel>>> getEmptySlots();

  Future<DataState<List>> getTimes();
}

class RoutineApiImpl implements RoutineApi {
  final String department;

  RoutineApiImpl(this.department);

  @override
  Future<DataState<List<EmptySlotModel>>> getEmptySlots() async {
    try {
      final response = await dio.get("$routine_api/$department/empty-slot");

      if (response.statusCode == 200) {
        List<EmptySlotModel> emptySlots = [];
        final responseData = response.data;
        for (Map<String, dynamic> slot in responseData) {
          emptySlots.add(EmptySlotModel.fromJson(slot));
        }
        return DataSuccess(emptySlots);
      } else {
        return DataFailed(
          response.statusMessage.toString(),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List<SlotModel>>> getSlots() async {
    try {
      final response =
          await dio.get("$routine_api/$department-routine");

      if (response.statusCode == 200) {
        List<SlotModel> slots = [];
        final responseData = response.data;
        for (Map<String, dynamic> slot in responseData) {
          slots.add(SlotModel.fromJson(slot));
        }
        return DataSuccess(slots);
      } else {
        return DataFailed(
          response.statusMessage.toString(),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }

  @override
  Future<DataState<List>> getTimes() async {
    try {
      final response = await dio.get("$routine_api/$department/times");

      if (response.statusCode == 200) {
        if (response.data.runtimeType == List && response.data != []) {
          final times = TimeModel.fromJson(response.data[0]);
          return DataSuccess(times.times!);
        } else {
          return const DataFailed("Couldn't Fetch Data");
        }
      } else {
        return DataFailed(
          response.statusMessage.toString(),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
