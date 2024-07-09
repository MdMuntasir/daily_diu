
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/home/data/data_sources/remote/call_routine_api.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/domain/repository/slot_repository.dart';
import 'package:hive/hive.dart';

import '../models/slot.dart';


// class RoutineRepoImpl implements SlotRepository{
//   final RoutineApi _routineApi;
//   RoutineRepoImpl(this._routineApi);
//
//   @override
//   Future<DataState<List<SlotModel>>> getRoutine() async{
//     try{
//       final httpResponse = await _routineApi.getStudentRoutineJson(BatchSection);
//
//       if (httpResponse.response.statusCode == HttpStatus.ok) {
//         return DataSuccess(httpResponse.data);
//       }
//
//       else {
//         return DataFailed(DioException(
//             error: httpResponse.response.statusMessage,
//             response: httpResponse.response,
//             type: DioExceptionType.badResponse,
//             requestOptions: httpResponse.response.requestOptions));
//       }
//     }
//     on DioException catch(e){
//       return DataFailed(e);
//     }
//   }
// }


Future<void> StoreRoutine(dept,info, isStudent) async{
  final _routineBox = Hive.box("routine_box");

  if(isStudent) {
    List _routine = await StudentRoutineAPI(batchSection: info, dept: dept).getRoutine();
    _routineBox.put("Routine", _routine);
  }
  else{
    List _routine = await TeacherRoutineAPI(ti: info,dept: dept).getRoutine();
    _routineBox.put("Routine", _routine);
  }
}

