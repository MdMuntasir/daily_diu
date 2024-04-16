import 'package:diu_student/features/routine/domain/entities/time.dart';

class TimeModel extends TimeEntity{
  const TimeModel({List ? time}):super(times: time);

  factory TimeModel.fromJson(Map<String,dynamic> map){
    return TimeModel(
      time: map["Time"] ?? []
    );
  }

}