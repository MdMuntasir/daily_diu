import 'package:hive/hive.dart';

import '../../../../core/util/model/user_info.dart';

void StoreUserInfo(userData, bool isStudent) {
  final _routineBox = Hive.box("routine_box");

  isStudent
      ? _routineBox.put("UserInfo", StudentInfoModel().toMap(userData))
      : _routineBox.put("UserInfo", TeacherInfoModel().toMap(userData));
}
