import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:diu_student/features/routine/domain/entities/slot.dart';
import 'package:diu_student/features/routine/domain/repository/slot_repository.dart';

class SlotRepoImpl implements SlotRepository{
  @override
  Future<DataState<List<SlotModel>>> getSlotInfo() {
    throw UnimplementedError();
  }

}