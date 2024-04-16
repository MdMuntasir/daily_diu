import 'package:diu_student/features/routine/domain/entities/time.dart';

import '../../../../core/resources/data_state.dart';

abstract class TimeRepository{
  Future<DataState<List<TimeEntity>>> getTimes();
}