import 'package:diu_student/features/home/data/models/user_info.dart';
import 'package:hive/hive.dart';

import '../../../../../core/resources/information_repository.dart';



void getUserInfo(){
  Map<String,dynamic> _map = {};
  Box _data = Hive.box("routine_box");
  Map _info = _data.get("UserInfo");
  _info.forEach((key,value){
    _map[key.toString()] = value;
  });
  if(_info["user"] == "Student"){
    studentInfo = StudentInfoModel.fromJson(_map);
  }
  else{
    teacherInfo = TeacherInfoModel.fromJson(_map);
  }
}