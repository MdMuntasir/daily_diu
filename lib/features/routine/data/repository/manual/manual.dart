import 'dart:convert';

import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class getAllSlots{
  final Box _box = Hive.box("routine_box");
  Future getAllSlotsRemotely(String department) async{
    var response = await http.get(Uri.https(routine_api_base));
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

