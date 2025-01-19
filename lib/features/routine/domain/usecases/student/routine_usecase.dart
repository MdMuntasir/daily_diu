import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/routine/domain/repository/slot_repository.dart';

import '../../../../../core/util/model/slot.dart';

class GetStudentRoutineUseCase implements UseCase<List<SlotModel>, void> {
  final SlotRepository _slotRepository;

  GetStudentRoutineUseCase(this._slotRepository);

  @override
  Future<DataState<List<SlotModel>>> call({void para}) {
    return _slotRepository.getRoutine();
  }
}
