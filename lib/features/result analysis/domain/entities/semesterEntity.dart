import 'package:equatable/equatable.dart';

class SemesterEntity extends Equatable {
  final semesterId;
  final semesterYear;
  final semesterName;

  SemesterEntity({
    required this.semesterId,
    required this.semesterYear,
    required this.semesterName,
  });

  @override
  List<Object?> get props => [
        semesterId,
        semesterYear,
        semesterName,
      ];
}
