import 'package:equatable/equatable.dart';

class StudentInfoEntity extends Equatable{
  final String? docID;
  final String? user;
  final String? name;
  final String? batch;
  final String? section;
  final String? id;
  final String? faculty;
  final String? department;
  final String? email;
  final String? password;
  final bool? verified;

  const StudentInfoEntity({
    this.docID,
    this.verified,
    this.user,
    this.name,
    this.batch,
    this.section,
    this.id,
    this.faculty,
    this.department,
    this.email,
    this.password});

  @override
  List<Object?> get props => [
    docID,
    user,
    name,
    batch,
    section,
    id,
    faculty,
    department,
    email,
    password,
    verified
  ];
}



class TeacherInfoEntity extends Equatable{
  final String? docID;
  final String? user;
  final String? name;
  final String? ti;
  final String? faculty;
  final String? department;
  final String? email;
  final String? password;
  final bool? verified;

  const TeacherInfoEntity({
    this.docID,
    this.verified,
    this.user,
    this.name,
    this.ti,
    this.faculty,
    this.department,
    this.email,
    this.password});

  @override
  List<Object?> get props => [
    docID,
    user,
    name,
    ti,
    faculty,
    department,
    email,
    password,
    verified
  ];
}