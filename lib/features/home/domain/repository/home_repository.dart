import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';

abstract class HomeRepository {
  Future<DataState<List<SlotEntity>>> getRoutine(UserEntity user);
}
