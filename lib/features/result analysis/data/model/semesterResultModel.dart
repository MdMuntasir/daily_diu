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
    data['semesterId'] = this.semesterId;
    data['semesterName'] = this.semesterName;
    data['semesterYear'] = this.semesterYear;
    data['customCourseId'] = this.customCourseId;
    data['courseTitle'] = this.courseTitle;
    data['totalCredit'] = this.totalCredit;
    data['pointEquivalent'] = this.pointEquivalent;
    data['gradeLetter'] = this.gradeLetter;
    data['cgpa'] = this.cgpa;
    return data;
  }
}
