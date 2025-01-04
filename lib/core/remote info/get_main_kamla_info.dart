import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/constants&variables/constants.dart';

import 'main_kamla_model.dart';

Future<void> getApiLink() async{
  final _checkConnection = await Connectivity().checkConnectivity();
  bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);
  if(isConnected) {
    var snapshot = await FirebaseFirestore.instance
        .collection("Admin")
        .doc("Moharaj")
        .get();
    MainKamlaModel kamla = MainKamlaModel.fromSnapShot(snapshot);
    link1 = kamla.api;
  }
}