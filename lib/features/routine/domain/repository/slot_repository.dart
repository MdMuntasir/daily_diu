import 'package:diu_student/core/resources/data_state.dart';

import '../../../../core/util/model/slot.dart';

abstract class SlotRepository {
  Future<DataState<List<SlotModel>>> getRoutine();
}