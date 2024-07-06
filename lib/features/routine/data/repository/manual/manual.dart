import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../empty slots/empty_slot_repo_impl.dart';
import '../time_repository_implement.dart';

class getAllSlots{
  final Box _box = Hive.box("routine_box");
  Future getAllSlotsRemotely(String department) async{
    Uri uri = Uri.parse(routine_api + "/${department.toLowerCase()}-routine");
    var response = await http.get(uri);

    List maps = [];
    List<SlotModel> models = [];
    if(response.statusCode == 200){

      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) {
        models.add(SlotModel.fromJson(element));
        maps.add(element);
      });
    }
    _box.put("${department}Slots", maps);
    return models;
  }

  getAllSlotsLocally(String department){
    List maps = _box.get("${department}Slots");
    List<SlotModel> jsonModel = [];
    maps.forEach((slot){
      Map<String, dynamic> map = {};
        slot.forEach((key, value){
          map[key.toString()] = value;
        });
        jsonModel.add(SlotModel.fromJson(map));
    });
    return jsonModel;
  }
}

Future getRoutine(department) async{
  final _checkConnection = await Connectivity().checkConnectivity();

  bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);
  if(isConnected) {
    try{
      allSlots = await getAllSlots().getAllSlotsRemotely(department);
      emptySlots = await getEmptySlots().getEmptySlotsRemotely(department);
      Times = await getTimes().getTimesRemotely(department);
    }
    catch(e){
      log(e.toString());
    }
  }
  else{
    allSlots = await getAllSlots().getAllSlotsLocally(department);
    emptySlots = await getEmptySlots().getEmptySlotsLocally(department);
    Times = await getTimes().getTimesLocally(department);
  }
}