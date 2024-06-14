import 'package:diu_student/features/home/domain/entities/user_info.dart';

class StudentInfoModel extends StudentInfoEntity{
  const StudentInfoModel({
    String? name,
    String? batch,
    String? section,
    String? id,
    String? faculty,
    String? department,
    String? email,
    String? password}) :
      super(
        name : name,
        batch : batch,
        section : section,
        id : id,
        faculty : faculty,
        department: department,
        email : email,
        password : password,
      );

  factory StudentInfoModel.fromJson(Map<String, dynamic> map){
    return StudentInfoModel(
      name: map["name"] ?? "",
      batch: map["batch"] ?? "",
      section: map["section"] ?? "",
      id: map["studentID"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
    );
  }
}



class TeacherInfoModel extends TeacherInfoEntity{
  const TeacherInfoModel({
    String? name,
    String? ti,
    String? faculty,
    String? department,
    String? email,
    String? password}) :
        super(
        name : name,
        ti: ti,
        faculty : faculty,
        department: department,
        email : email,
        password : password,
      );

  factory TeacherInfoModel.fromJson(Map<String, dynamic> map){
    return TeacherInfoModel(
      name: map["name"] ?? "",
      ti: map["ti"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
    );
  }
}
