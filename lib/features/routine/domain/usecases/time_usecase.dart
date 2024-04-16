import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/routine/data/repository/time_repository_implement.dart';
import 'package:diu_student/features/routine/domain/entities/time.dart';
import 'package:diu_student/features/routine/domain/repository/time_repository.dart';

import '../../../../core/resources/data_state.dart';

class GetTimeUseCase implements UseCase<DataState<List<TimeEntity>>,void>{
  final TimeRepository _timeRepository;
   GetTimeUseCase(this._timeRepository);

  @override
  Future<DataState<List<TimeEntity>>> call({void para}) {
    return _timeRepository.getTimes();
  }

}