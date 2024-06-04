import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/data/models/time.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/routine/domain/repository/time_repository.dart';
import 'package:http/http.dart' as http;

class TimeRepoImpl extends TimeRepository{
  final RoutineApi _routineApi;
  TimeRepoImpl(this._routineApi);

  @override
  Future<DataState<List<TimeModel>>> getTimes() async {
    try{
      final httpResponse = await _routineApi.getTimes();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    }
    on DioException catch(e){
      return DataFailed(e);
    }
  }

}


class getTimesRemotely{

  Future getTime() async{
    var response = await http.get(Uri.https("diuroutineapi-production.up.railway.app","/times"));

    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body);
      return TimeModel.fromJson(json[0]).times!;
    }
    else{
      return [];
    }
  }
}