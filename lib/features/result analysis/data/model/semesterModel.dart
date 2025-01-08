import 'package:diu_student/features/result%20analysis/domain/entities/semesterEntity.dart';

class SemesterModel extends SemesterEntity {
  SemesterModel({
    required super.semesterId,
    required super.semesterYear,
    required super.semesterName,
  });

  factory SemesterModel.fromJson(Map<String, dynamic> json) {
    return SemesterModel(
      semesterId: json["semesterId"] ?? "",
      semesterYear: json["semesterYear"] ?? "",
      semesterName: json["semesterName"] ?? "",
    );
  }
}
