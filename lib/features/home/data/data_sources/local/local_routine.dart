import 'package:diu_student/features/home/data/models/slot.dart';
import 'package:diu_student/features/home/data/repository/routine_repo_implement.dart';
import 'package:hive/hive.dart';

List<SlotModel> MainRoutine = [];

Future<void> getRoutineLocally(batchSec) async{
  Box _data = Hive.box("routine_box");
  await StoreRoutine(batchSec);
  List _routine = _data.get(2);
  List<SlotModel> jsonModel = [];
  _routine.forEach((slot){
    jsonModel.add(SlotModel.fromJson(slot));
  });
  MainRoutine = jsonModel;

}