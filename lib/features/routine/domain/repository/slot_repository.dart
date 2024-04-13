import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/domain/entities/slot.dart';

abstract class SlotRepository {

  Future<DataState<List<SlotEntity>>> getSlotInfo();
}