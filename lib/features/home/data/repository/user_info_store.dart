import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

import '../models/user_info.dart';

void StoreUserInfo(userData,bool isStudent) {
  final _routineBox = Hive.box("routine_box");

  isStudent ?
  _routineBox.put("UserInfo", StudentModelToMap(userData)):
  _routineBox.put("UserInfo", TeacherModelToMap(userData));

}
