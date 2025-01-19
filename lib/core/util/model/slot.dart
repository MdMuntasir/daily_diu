import 'package:diu_student/core/util/Entities/slot.dart';

class SlotModel extends SlotEntity {
  const SlotModel(
      {required super.dept,
      required super.room,
      required super.time,
      required super.batch,
      required super.section,
      required super.course,
      required super.ti,
      required super.day});

  factory SlotModel.fromJson(Map<String, dynamic> map) {
    return SlotModel(
      dept: map["department"] ?? "",
      room: map["room"] ?? "",
      time: map["time"] ?? "",
      batch: map["batch"] ?? "",
      section: map["section"] ?? "",
      course: map["course"] ?? "",
      ti: map["ti"] ?? "",
      day: map["day"] ?? "",
    );
  }


  Map<String, dynamic> toJson(){
    Map<String, dynamic> data = <String,dynamic>{};
    data["day"] = day;
    data["dept"] = dept;
    data["room"] = room;
    data["batch"] = batch;
    data["ti"] = ti;
    data["section"] = section;
    data["course"] = course;
    data["time"] = time;
    return data;
  }
}
