import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';

class EmptySlotModel extends EmptySlotEntity{
  EmptySlotModel({
    required super.room,
    required super.time,
    required super.day
  });

  factory EmptySlotModel.fromJson(Map<String,dynamic> map){
    return EmptySlotModel(
        room: map["room"] ?? "",
        time: map["time"] ?? "",
        day: map["day"] ?? "");
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = new Map<String,dynamic>();
    data["room"] = room;
    data["time"] = time;
    data["day"] = day;
    return data;
  }

}