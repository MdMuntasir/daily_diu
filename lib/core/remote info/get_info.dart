import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/links/api_links.dart';

import 'main_info_model.dart';

Future<void> getApiLink() async {
  final _checkConnection = await Connectivity().checkConnectivity();
  bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) ||
      _checkConnection.contains(ConnectivityResult.wifi);
  if (isConnected) {
    var snapshot = await FirebaseFirestore.instance
        .collection("Admin")
        .doc("Moharaj")
        .get();
    MainInfoModel kamla = MainInfoModel.fromSnapShot(snapshot);
    link1 = kamla.api;
  }
}
