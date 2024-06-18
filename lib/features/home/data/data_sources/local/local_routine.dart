import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/features/home/data/models/slot.dart';
import 'package:diu_student/features/home/data/repository/routine_repo_implement.dart';
import 'package:hive/hive.dart';

List<HomeSlotModel> MainRoutine = [];


Future<void> getRoutineLocally(batchSec, isStudent) async{
  Box _data = Hive.box("routine_box");
  final _checkConnection = await Connectivity().checkConnectivity();

  bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);
  if(isConnected) {
    await StoreRoutine(batchSec, isStudent);
  }
  List _routine = _data.get("Routine");
  List<HomeSlotModel> jsonModel = [];

  _routine.forEach((slot){
    Map<String, dynamic> map = {};
    if(isConnected) {
      map = slot;
      jsonModel.add(HomeSlotModel.fromJson(slot));
    }
    else{
      slot.forEach((key, value){
        map[key.toString()] = value;
      });
      jsonModel.add(HomeSlotModel.fromJson(map));
    }
  });
  MainRoutine = jsonModel;

}