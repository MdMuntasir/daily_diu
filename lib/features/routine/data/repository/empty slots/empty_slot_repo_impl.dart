import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/routine/data/data_sources/remote/routine_api.dart';
import 'package:diu_student/features/routine/data/models/empty_slot_model.dart';
import 'package:diu_student/features/routine/domain/repository/empty_slot_repository.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/resources/information_repository.dart';

class EmptySlotRepoImpl extends EmptySlotRepository{

  final RoutineApi _routineApi;
  EmptySlotRepoImpl(this._routineApi);

  @override
  Future<DataState<List<EmptySlotModel>>> getEmptySlots() async{

    try {
      final httpResponse = await _routineApi.getEmptySlots();

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      }

      else {
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







class getEmptySlots{
  final Box _box = Hive.box("routine_box");

  Future getEmptySlotsRemotely(String department) async {
    final response = await http.get(Uri.https(routine_api_base , "/empty-slot"));
    List maps = [];
    List<EmptySlotModel> models = [];
    if(response.statusCode == 200){
      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) {
        models.add(EmptySlotModel.fromJson(element));
        maps.add(element);
      });
      // emptySlots = map;
    }
    _box.put("${department}EmptySlot", maps);
    return models;
  }


  getEmptySlotsLocally(String department){
    List maps = _box.get("${department}EmptySlot");
    List<EmptySlotModel> jsonModel = [];
    maps.forEach((slot){
      Map<String, dynamic> map = {};
      slot.forEach((key, value){
        map[key.toString()] = value;
      });
      jsonModel.add(EmptySlotModel.fromJson(map));
    });
    return jsonModel;
  }

}