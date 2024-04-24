import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';

class EmptySlotModel extends EmptySlotEntity{
  EmptySlotModel({
    required String room,
    required String time,
    required String day
  }) : super(
    room: room,
    time: time,
    day: day
  );

  factory EmptySlotModel.fromJson(Map<String,dynamic> map){
    return EmptySlotModel(
        room: map["room"] ?? "",
        time: map["time"] ?? "",
        day: map["day"] ?? "");
  }

}