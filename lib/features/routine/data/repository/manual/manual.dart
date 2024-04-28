import 'dart:convert';

import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:diu_student/features/routine/domain/repository/information_repository.dart';
import 'package:http/http.dart' as http;

class getAllSlotsRemotely{
  Future getAllSlots() async{
    var response = await http.get(Uri.https(routine_api_base));
    List<SlotModel> map = [];
    if(response.statusCode == 200){

      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) {
        map.add(SlotModel.fromJson(element));
      });
      // allSlots = map;
    }
    return map;
  }
}