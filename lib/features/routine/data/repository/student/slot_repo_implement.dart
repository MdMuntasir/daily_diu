import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/domain/repository/slot_repository.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/util/model/slot.dart';

// class StudentRoutineImpl implements SlotRepository {
//   final RoutineApi _routineApi;
//
//   StudentRoutineImpl(this._routineApi);
//
//   @override
//   Future<DataState<List<SlotModel>>> getRoutine() async {
//     try {
//       final httpResponse =
//           await _routineApi.getStudentRoutineJson(BatchSection);
//
//       if (httpResponse.response.statusCode == HttpStatus.ok) {
//         return DataSuccess(httpResponse.data);
//       } else {
//         return DataFailed("Something Went Wrong");
//       }
//     } on DioException catch (e) {
//       return DataFailed(e.message.toString());
//     }
//   }
// }

class getStudentRoutineRemotely {
  String batchSection, dept;

  getStudentRoutineRemotely({required this.batchSection, required this.dept});

  Future<List<SlotModel>> getRoutine() async {
    final uri = Uri.parse(
        routine_api + "/$dept/student-routine?batchSection=$batchSection");
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      List<SlotModel> map = [];
      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) {
        map.add(SlotModel.fromJson(element));
      });
      return map;
    } else {
      return [];
    }
  }
}
