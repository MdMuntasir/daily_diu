import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/features/home/domain/entities/user_info.dart';

class StudentInfoModel extends StudentInfoEntity{
  const StudentInfoModel({
    String? user,
    String? name,
    String? batch,
    String? section,
    String? id,
    String? faculty,
    String? department,
    String? email,
    String? password}) :
      super(
        user : user,
        name : name,
        batch : batch,
        section : section,
        id : id,
        faculty : faculty,
        department: department,
        email : email,
        password : password,
      );

  factory StudentInfoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final map = document.data()!;
    return StudentInfoModel(
      user: map["user"] ?? "",
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


  factory StudentInfoModel.fromJson(Map<String,dynamic> map){
    return StudentInfoModel(
      user: map["user"] ?? "",
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
    String? user,
    String? name,
    String? ti,
    String? faculty,
    String? department,
    String? email,
    String? password}) :
        super(
        user: user,
        name : name,
        ti: ti,
        faculty : faculty,
        department: department,
        email : email,
        password : password,
      );

  factory TeacherInfoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final map = document.data()!;
    return TeacherInfoModel(
      user: map["user"] ?? "",
      name: map["name"] ?? "",
      ti: map["ti"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
    );
  }


  factory TeacherInfoModel.fromJson(Map<String,dynamic> map){
    return TeacherInfoModel(
      user: map["user"] ?? "",
      name: map["name"] ?? "",
      ti: map["ti"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
    );
  }

}





Map StudentModelToMap(StudentInfoModel map){
  Map model = {
    "user" : map.user ?? "",
    "name": map.name ?? "",
    "batch": map.batch ?? "",
    "section": map.section ?? "",
    "studentID": map.id ?? "",
    "faculty": map.faculty ?? "",
    "department": map.department ?? "",
    "email": map.email ?? "",
    "password": map.password ?? "",
  };
  return model;
}


Map TeacherModelToMap(TeacherInfoModel map){
  Map model = {
    "user" : map.user ?? "",
    "name": map.name ?? "",
    "ti" : map.ti ?? "",
    "faculty": map.faculty ?? "",
    "department": map.department ?? "",
    "email": map.email ?? "",
    "password": map.password ?? "",
  };
  return model;
}