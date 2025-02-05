import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/features/home/data/data_sources/remote/remote_user_info.dart';
import 'package:diu_student/core/util/model/user_info.dart';
import 'package:hive/hive.dart';

import '../../../../../core/resources/information_repository.dart';

Future<void> getUserInfo() async {
  Map<String, dynamic> _map = {};
  Box _data = Hive.box("routine_box");

  final _checkConnection = await Connectivity().checkConnectivity();
  bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) ||
      _checkConnection.contains(ConnectivityResult.wifi);
  if (isConnected) {
    try {
      await getUserInfoRemotely();
    } on Exception {
      log("Couldn't fetch user info");
    }
  }

  Map _info = _data.get("UserInfo");
  _info.forEach((key, value) {
    _map[key.toString()] = value;
  });

  if (_info["user"] == "Student") {
    studentInfo = StudentInfoModel.fromJson(_map);
  } else {
    teacherInfo = TeacherInfoModel.fromJson(_map);
  }
}
