import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';

import '../entities/semesterResultEntity.dart';
import '../repository/resultRepository.dart';

class SemesterSemesterResultUseCase
    implements UseCase<List<SemesterResultEntity>, void> {
  final ResultRepo _resultRepo;

  const SemesterSemesterResultUseCase(this._resultRepo);

  @override
  Future<DataState<List<SemesterResultEntity>>> call({para}) async {
    return await _resultRepo.getSemesterResult();
  }
}
