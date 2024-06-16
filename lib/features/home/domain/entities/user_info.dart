import 'package:equatable/equatable.dart';

class StudentInfoEntity extends Equatable{
  final String? user;
  final String? name;
  final String? batch;
  final String? section;
  final String? id;
  final String? faculty;
  final String? department;
  final String? email;
  final String? password;

  const StudentInfoEntity({
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
    user,
    name,
    batch,
    section,
    id,
    faculty,
    department,
    email,
    password
  ];
}



class TeacherInfoEntity extends Equatable{
  final String? user;
  final String? name;
  final String? ti;
  final String? faculty;
  final String? department;
  final String? email;
  final String? password;

  const TeacherInfoEntity({
    this.user,
    this.name,
    this.ti,
    this.faculty,
    this.department,
    this.email,
    this.password});

  @override
  List<Object?> get props => [
    user,
    name,
    ti,
    faculty,
    department,
    email,
    password
  ];
}