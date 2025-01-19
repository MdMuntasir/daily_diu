import 'package:diu_student/features/result%20analysis/domain/entities/semesterResultEntity.dart';


class SemesterResultModel extends SemesterResultEntity{
  SemesterResultModel(
      {
       required super.semesterId,
       required super.semesterName,
       required super.semesterYear,
       required super.customCourseId,
       required super.courseTitle,
       required super.totalCredit,
       required super.pointEquivalent,
       required super.gradeLetter,
       required super.cgpa,});

  factory SemesterResultModel.fromJson(Map<String, dynamic> json) {
    return SemesterResultModel(
        semesterId : json['semesterId'] ?? "",
        semesterName : json['semesterName'] ?? "",
        semesterYear : json['semesterYear'] ?? "",
        customCourseId : json['customCourseId'] ?? "",
        courseTitle : json['courseTitle'] ?? "",
        totalCredit : json['totalCredit'] ?? "",
        pointEquivalent : json['pointEquivalent'] ?? "",
        gradeLetter : json['gradeLetter'] ?? "",
        cgpa : json['cgpa'] ?? "",
    );

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['semesterId'] = semesterId;
    data['semesterName'] = semesterName;
    data['semesterYear'] = semesterYear;
    data['customCourseId'] = customCourseId;
    data['courseTitle'] = courseTitle;
    data['totalCredit'] = totalCredit;
    data['pointEquivalent'] = pointEquivalent;
    data['gradeLetter'] = gradeLetter;
    data['cgpa'] = cgpa;
    return data;
  }
}
