import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_info.dart';
import '../../repository/user_info_store.dart';

Future getUserInfoRemotely() async {
  User? user = FirebaseAuth.instance.currentUser;
  await user?.reload();

  FirebaseFirestore _db = FirebaseFirestore.instance;

  final snapshot1 = await _db.collection("student").where("email", isEqualTo: user?.email).get();
  final snapshot2 = await _db.collection("teacher").where("email", isEqualTo: user?.email).get();

  if(snapshot1.docs.isNotEmpty){
    StudentInfoModel userData = snapshot1.docs.map((e) => StudentInfoModel.fromSnapshot(e)).single;
    StoreUserInfo(userData, true);
  }

  else{
    TeacherInfoModel userData = snapshot2.docs.map((e) => TeacherInfoModel.fromSnapshot(e)).single;
    StoreUserInfo(userData, false);
  }
}