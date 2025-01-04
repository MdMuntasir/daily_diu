import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/routine/domain/entities/slot.dart';
import 'package:diu_student/features/routine/domain/repository/slot_repository.dart';

import '../../../../../core/util/model/slot.dart';

class GetStudentRoutineUseCase implements UseCase<DataState<List<SlotModel>>,void>{
  final SlotRepository _slotRepository;

  GetStudentRoutineUseCase(this._slotRepository);

  @override
  Future<DataState<List<SlotModel>>> call({void para}) {
    return _slotRepository.getRoutine();
  }
}