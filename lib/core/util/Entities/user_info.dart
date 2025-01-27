import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? docID;
  final String? user;
  final String? name;
  final String? batch;
  final String? section;
  final String? ti;
  final String? studentID;
  final String? faculty;
  final String? department;
  final String? email;
  final String? password;
  final bool? verified;
  final String? notice;

  const UserEntity(
      {this.docID,
      this.user,
      this.name,
      this.batch,
      this.section,
      this.ti,
      this.studentID,
      this.faculty,
      this.department,
      this.email,
      this.password,
      this.verified,
      this.notice});

  @override
  List<Object?> get props => [
        ti,
        docID,
        user,
        name,
        batch,
        section,
        ti,
        studentID,
        faculty,
        department,
        email,
        password,
        verified,
        notice,
      ];
}
