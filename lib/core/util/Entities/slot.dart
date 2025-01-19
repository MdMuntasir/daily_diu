import 'package:equatable/equatable.dart';

class SlotEntity extends Equatable{
  final String? dept;
  final String? room;
  final String? time;
  final String? batch;
  final String? section;
  final String? course;
  final String? ti;
  final String? day;

  const SlotEntity({
      this.dept,
      this.room,
      this.time,
      this.batch,
      this.section,
      this.course,
      this.ti,
      this.day});

  @override

  List<Object?> get props => [
    dept,
    room,
    time,
    batch,
    section,
    course,
    ti,
    day
  ];
}
