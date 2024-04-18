import 'dart:convert';
import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:http/http.dart' as http;

class getTeacherRoutineRemotely{
  String ti;
  getTeacherRoutineRemotely({required this.ti});

  Future<List<SlotModel>> getRoutine() async{
    final uri = Uri.parse(routine_api+"/teacher-routine?teacherInitial=$ti");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      List<SlotModel> map = [];
      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) {
        map.add(SlotModel.fromJson(element));
      });
      return map;
    }
    else{
      return [];
    }
  }
}