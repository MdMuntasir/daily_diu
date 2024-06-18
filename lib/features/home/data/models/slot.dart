import 'package:diu_student/features/routine/domain/entities/slot.dart';


class HomeSlotModel extends SlotEntity {
  const HomeSlotModel({
    String? room,
    String? time,
    String? batch,
    String? section,
    String? course,
    String? ti,
    String? day
    }) : super(
    room: room,
    time: time,
    batch: batch,
    section: section,
    course: course,
    ti: ti,
    day: day
  );

  factory HomeSlotModel.fromJson(Map<String, dynamic> map){
    return HomeSlotModel(
      room: map["room"] ?? "",
      time: map["time"] ?? "",
      batch: map["batch"] ?? "",
      section: map["section"] ?? "",
      course: map["course"] ?? "",
      ti: map["ti"] ?? "",
      day: map["day"] ?? "",
    );
  }
}