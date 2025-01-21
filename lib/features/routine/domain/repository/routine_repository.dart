import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';

abstract interface class RoutineRepository {
  Future<DataState<List>> getTimes();

  Future<DataState<List<SlotEntity>>> getAllSlots();

  Future<DataState<List<EmptySlotEntity>>> getEmptySlots();
}
