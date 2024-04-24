import '../../../../core/resources/data_state.dart';
import '../entities/empty_slot.dart';

abstract class EmptySlotRepository {
  Future<DataState<List<EmptySlotEntity>>> getEmptySlots();
}