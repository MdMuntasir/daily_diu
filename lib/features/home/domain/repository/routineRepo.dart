import 'package:diu_student/core/resources/data_state.dart';
import '../../../../core/util/model/slot.dart';


abstract class RoutineRepo {
  Future<DataState<List<SlotModel>>> getRoutine();
}