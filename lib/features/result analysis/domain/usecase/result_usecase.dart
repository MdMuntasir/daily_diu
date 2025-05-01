import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';

import '../entities/semesterResultEntity.dart';
import '../repository/resultRepository.dart';

class ResultUseCase
    implements UseCase<List<List<SemesterResultEntity>>, String> {
  final ResultRepo _resultRepo;

  const ResultUseCase(this._resultRepo);

  @override
  Future<DataState<List<List<SemesterResultEntity>>>> call(
      {String? para}) async {
    return await _resultRepo.getResult(para!);
  }
}
