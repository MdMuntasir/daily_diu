import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';
import 'package:diu_student/features/routine/domain/repository/empty_slot_repository.dart';

class GetEmptySlotUseCase extends UseCase<DataState<List<EmptySlotEntity>>,void>{
  final EmptySlotRepository _emptySlotRepository;
  GetEmptySlotUseCase(this._emptySlotRepository);

  @override
  Future<DataState<List<EmptySlotEntity>>> call({void para}) {
    return _emptySlotRepository.getEmptySlots();
  }

}