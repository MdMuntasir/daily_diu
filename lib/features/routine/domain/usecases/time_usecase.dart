import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/routine/domain/repository/routine_repository.dart';
import '../../../../core/resources/data_state.dart';

class GetTimeUseCase implements UseCase<List, void> {
  final RoutineRepository _routineRepository;

  GetTimeUseCase(this._routineRepository);

  @override
  Future<DataState<List>> call({void para}) async {
    return await _routineRepository.getTimes();
  }
}
