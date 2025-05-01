import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';

import '../entities/semesterResultEntity.dart';
import '../repository/resultRepository.dart';

class SemesterResultUseCase
    implements UseCase<List<SemesterResultEntity>, SemesterResultParameter> {
  final ResultRepo _resultRepo;

  const SemesterResultUseCase(this._resultRepo);

  @override
  Future<DataState<List<SemesterResultEntity>>> call(
      {SemesterResultParameter? para}) async {
    return await _resultRepo.getSemesterResult(para?.id, para?.semesterID);
  }
}

class SemesterResultParameter {
  final id;
  final semesterID;

  const SemesterResultParameter(
    this.id,
    this.semesterID,
  );
}
