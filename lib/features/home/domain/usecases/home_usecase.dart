import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/home/domain/repository/home_repository.dart';

class HomeUseCase implements UseCase<List<SlotEntity>, void> {
  final HomeRepository homeRepository;

  const HomeUseCase(this.homeRepository);

  @override
  Future<DataState<List<SlotEntity>>> call({void para}) async {
    return await homeRepository.getRoutine();
  }
}
