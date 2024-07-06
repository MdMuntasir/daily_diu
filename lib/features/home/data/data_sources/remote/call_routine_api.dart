import 'dart:convert';

import '../../../../../core/constants&variables/constants.dart';
import '../../models/slot.dart';
import 'package:http/http.dart' as http;



class StudentRoutineAPI{
  final String batchSection, dept;
  StudentRoutineAPI({required this.batchSection, required this.dept});

  Future<List> getRoutine() async{
    final uri = Uri.parse(routine_api+"/$dept/student-routine?batchSection=$batchSection");
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
  final String ti, dept;
  TeacherRoutineAPI({required this.ti, required this.dept});

  Future<List> getRoutine() async{
    final uri = Uri.parse(routine_api+"/$dept/full-teacher-routine?teacherInitial=$ti");
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