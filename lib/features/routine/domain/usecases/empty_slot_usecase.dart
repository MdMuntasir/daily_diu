import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';
import 'package:diu_student/features/routine/domain/repository/routine_repository.dart';

class GetEmptySlotUseCase extends UseCase<List<EmptySlotEntity>, void> {
  final RoutineRepository _routineRepository;

  GetEmptySlotUseCase(this._routineRepository);

  @override
  Future<DataState<List<EmptySlotEntity>>> call({void para}) async {
    return await _routineRepository.getEmptySlots();
  }
}
