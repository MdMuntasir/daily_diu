import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/routine/domain/repository/routine_repository.dart';

class GetAllSlotUseCase implements UseCase<List<SlotEntity>, void> {
  final RoutineRepository _routineRepository;

  const GetAllSlotUseCase(this._routineRepository);

  @override
  Future<DataState<List<SlotEntity>>> call({void para}) async {
    return await _routineRepository.getAllSlots();
  }
}
