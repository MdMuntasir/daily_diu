import 'package:equatable/equatable.dart';

class SemesterResultEntity extends Equatable{
  final semesterId;
  final semesterName;
  final semesterYear;
  final customCourseId;
  final courseTitle;
  final totalCredit;
  final pointEquivalent;
  final gradeLetter;
  final cgpa;

  SemesterResultEntity({
    required this.semesterId,
    required this.semesterName,
    required this.semesterYear,
    required this.customCourseId,
    required this.courseTitle,
    required this.totalCredit,
    required this.pointEquivalent,
    required this.gradeLetter,
    required this.cgpa,});

  @override
  List<Object?> get props => [
    semesterId,
    semesterName,
    semesterYear,
    customCourseId,
    courseTitle,
    totalCredit,
    pointEquivalent,
    gradeLetter,
    cgpa,
  ];
}