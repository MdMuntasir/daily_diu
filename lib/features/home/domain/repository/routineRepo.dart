import 'package:diu_student/core/resources/data_state.dart';
import '../../data/models/slot.dart';


abstract class RoutineRepo {
  Future<DataState<List<HomeSlotModel>>> getRoutine();
}