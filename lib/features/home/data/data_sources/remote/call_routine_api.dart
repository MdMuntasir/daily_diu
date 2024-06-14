import 'dart:convert';

import '../../../../../core/constants&variables/constants.dart';
import '../../models/slot.dart';
import 'package:http/http.dart' as http;



class StudentRoutineAPI{
  String batchSection;
  StudentRoutineAPI({required this.batchSection});

  Future<List> getRoutine() async{
    final uri = Uri.parse(routine_api+"/student-routine?batchSection=$batchSection");
    var response = await http.get(uri);

    if(response.statusCode == 200){
      List _routine = [];
      List<dynamic> json = jsonDecode(response.body);
      json.forEach((element) {
        Map<String,dynamic> map= element;
        _routine.add(map);
      });
      return _routine;
    }
    else{
      return [];
    }
  }
}





class TeacherRoutineAPI{
  String ti;
  TeacherRoutineAPI({required this.ti});

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