import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/data/models/time.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/routine/domain/repository/time_repository.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../../../core/constants&variables/constants.dart';

class TimeRepoImpl extends TimeRepository {
  final RoutineApi _routineApi;

  TimeRepoImpl(this._routineApi);

  @override
  Future<DataState<List<TimeModel>>> getTimes() async {
    try {
      final httpResponse = await _routineApi.getTimes();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed("Something Went Wrong");
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}

class getTimes {
  final Box _box = Hive.box("routine_box");

  Future getTimesRemotely(String department) async {
    Uri uri = Uri.parse(routine_api + "/$department/times");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      _box.put("${department}Times", json[0]["Time"]);
      return TimeModel.fromJson(json[0]).times!;
    } else {
      return [];
    }
  }

  getTimesLocally(String department) {
    List time = _box.get("${department}Times");
    return time;
  }
}
