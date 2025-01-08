import 'package:dio/dio.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/result%20analysis/data/model/semesterModel.dart';
import 'package:diu_student/features/result%20analysis/data/model/semesterResultModel.dart';
import 'package:diu_student/features/result%20analysis/domain/entities/semesterResultEntity.dart';
import 'package:diu_student/features/result%20analysis/domain/repository/resultRepository.dart';

import '../data sources/remote/api_data_source.dart';

class ResultRepositoryImpl implements ResultRepo {
  final RemoteResult remoteResult;
  final RemoteSemesters remoteSemesters;

  ResultRepositoryImpl(
    this.remoteResult,
    this.remoteSemesters,
  );

  @override
  Future<DataState<List<List<SemesterResultEntity>>>> getResult() async {
    try {
      final semestersData = await remoteSemesters.getSemesters();
      List<List<SemesterResultModel>> results = [];
      if (semestersData is DataSuccess<List<SemesterModel>>) {
        final semesters = semestersData.data;
        if (semesters != null) {
          for (SemesterModel semester in semesters) {
            var result = await remoteResult.getResult(
              semesterId: semester.semesterId,
            );
            if (result is DataSuccess<List<SemesterResultModel>>) {
              if (result.data != null) {
                results.add(result.data!);
              }
            }
          }
        }
      }
      return DataSuccess(results);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
