import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/features/home/domain/entities/user_info.dart';

class StudentInfoModel extends StudentInfoEntity{
  const StudentInfoModel({
    super.docID,
    super.verified,
    super.user,
    super.name,
    super.batch,
    super.section,
    super.id,
    super.faculty,
    super.department,
    super.email,
    super.password});

  factory StudentInfoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final map = document.data()!;
    return StudentInfoModel(
      docID: map["docID"] ?? "",
      user: map["user"] ?? "",
      name: map["name"] ?? "",
      batch: map["batch"] ?? "",
      section: map["section"] ?? "",
      id: map["studentID"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
      verified: map["verified"] ?? false,
    );
  }


  factory StudentInfoModel.fromJson(Map<String,dynamic> map){
    return StudentInfoModel(
      docID: map["docID"] ?? "",
      user: map["user"] ?? "",
      name: map["name"] ?? "",
      batch: map["batch"] ?? "",
      section: map["section"] ?? "",
      id: map["studentID"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
      verified: map["verified"] ?? false,
    );
  }


  Map<String, dynamic> toMap(StudentInfoModel model){
    return {
      'verified' : model.verified ?? false,
      "docID" : model.docID ?? "",
      "user" : model.user ?? "",
      "name": model.name ?? "",
      "batch": model.batch ?? "",
      "section": model.section ?? "",
      "studentID": model.id ?? "",
      "faculty": model.faculty ?? "",
      "department": model.department ?? "",
      "email": model.email ?? "",
      "password": model.password ?? "",
    };
  }

}



class TeacherInfoModel extends TeacherInfoEntity{
  const TeacherInfoModel({
    super.docID,
    super.verified,
    super.user,
    super.name,
    super.ti,
    super.faculty,
    super.department,
    super.email,
    super.password});

  factory TeacherInfoModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final map = document.data()!;
    return TeacherInfoModel(
      docID: map["docID"] ?? "",
      user: map["user"] ?? "",
      name: map["name"] ?? "",
      ti: map["ti"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
      verified: map["verified"] ?? false,
    );
  }


  factory TeacherInfoModel.fromJson(Map<String,dynamic> map){
    return TeacherInfoModel(
      docID: map["docID"] ?? "",
      user: map["user"] ?? "",
      name: map["name"] ?? "",
      ti: map["ti"] ?? "",
      faculty: map["faculty"] ?? "",
      department: map["department"] ?? "",
      email: map["email"] ?? "",
      password: map["password"] ?? "",
      verified: map["verified"] ?? false,
    );
  }

  Map<String, dynamic> toMap(TeacherInfoModel model){
    return {
      'verified' : model.verified ?? false,
      "docID" : model.docID ?? "",
      "user" : model.user ?? "",
      "name": model.name ?? "",
      "ti" : model.ti ?? "",
      "faculty": model.faculty ?? "",
      "department": model.department ?? "",
      "email": model.email ?? "",
      "password": model.password ?? "",
    };
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