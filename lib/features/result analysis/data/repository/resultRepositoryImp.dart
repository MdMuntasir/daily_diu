import 'package:dio/dio.dart';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/result%20analysis/data/data%20sources/local/result_local_data_source.dart';
import 'package:diu_student/features/result%20analysis/data/model/semesterModel.dart';
import 'package:diu_student/features/result%20analysis/data/model/semesterResultModel.dart';
import 'package:diu_student/features/result%20analysis/domain/entities/semesterResultEntity.dart';
import 'package:diu_student/features/result%20analysis/domain/repository/resultRepository.dart';

import '../data sources/remote/api_data_source.dart';

class ResultRepositoryImpl implements ResultRepo {
  final RemoteResult remoteResult;
  final RemoteSemesters remoteSemesters;
  final ResultLocalDataSource resultLocalDataSource;
  final ConnectionChecker connectionChecker;

  ResultRepositoryImpl(
    this.remoteResult,
    this.remoteSemesters,
    this.connectionChecker,
    this.resultLocalDataSource,
  );

  @override
  Future<DataState<List<List<SemesterResultEntity>>>> getResult() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        List<List<SemesterResultModel>> results =
            resultLocalDataSource.fetchData();
        return results.isEmpty
            ? const DataFailed("No internet connection")
            : DataSuccess(results);
      }
      final semestersData = await remoteSemesters.getSemesters();
      List<List<SemesterResultModel>> results = [];
      if (semestersData is DataSuccess<List<SemesterModel>>) {
        final semesters = semestersData.data;

        if (semesters!.isNotEmpty) {
          int c = 0;
          for (SemesterModel semester in semesters) {
            final result = await remoteResult.getResult(
              semesterId: semester.semesterId,
            );
            if (result is DataSuccess<List<SemesterResultModel>> &&
                result.data!.isNotEmpty) {
              results.add(result.data!);
            }

            if (c++ >= 20 ||
                int.parse(semester.semesterId.toString()) ==
                    int.parse(remoteResult.id.toString().split("-")[0])) {
              break;
            }
          }
        }
      }
      resultLocalDataSource.uploadData(results: results);

      return DataSuccess(results);
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
