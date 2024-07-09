import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:diu_student/features/login%20system/presentation/widgets/textStyle.dart';
import 'package:diu_student/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/resources/information_repository.dart';
import 'features/home/data/data_sources/local/local_routine.dart';
import 'features/home/data/data_sources/local/local_user_info.dart';
import 'features/home/data/models/user_info.dart';
import 'firebase_options.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await Hive.initFlutter();
    var box = await Hive.openBox("routine_box");


    User? user = FirebaseAuth.instance.currentUser;
    bool hasUser = user != null;

    final _checkConnection = await Connectivity().checkConnectivity();
    Online = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);

    android_info = await DeviceInfoPlugin().androidInfo;

    if(hasUser){
      final snapshot1 = await FirebaseFirestore.instance.collection("student").where('email' , isEqualTo: user.email).get();
      final snapshot2 = await FirebaseFirestore.instance.collection("teacher").where('email' , isEqualTo: user.email).get();

      if(snapshot1.docs.isNotEmpty){
        StudentInfoModel userData = snapshot1.docs.map((e) => StudentInfoModel.fromSnapshot(e)).single;
        if(userData.verified == false){
          hasUser = false;
          await user.reauthenticateWithCredential(
              EmailAuthProvider.credential(
                  email: user.email!,
                  password: userData.password!)
          ).then((value) async {
            await user.delete().then((value) async {
              await FirebaseFirestore.instance.collection("student").doc(userData.docID).delete();
            },);
          },);


        }
      }

      else if(snapshot2.docs.isNotEmpty){
        TeacherInfoModel userData = snapshot2.docs.map((e) => TeacherInfoModel.fromSnapshot(e)).single;
        if(userData.verified == false){
          hasUser = false;

          await user.reauthenticateWithCredential(
              EmailAuthProvider.credential(
                  email: user.email!,
                  password: userData.password!)
          ).then((value) async {
            await user.delete().then((value) async {
              await FirebaseFirestore.instance.collection("teacher").doc(userData.docID).delete();
            },);
          },);

        }
      }

      else{
        hasUser = false;
        await user.delete();
      }
    }


    if(hasUser){
      Box _box = Hive.box("routine_box");
      Map _info = _box.get("UserInfo");
      await getUserInfo();
      if(_info["user"] == "Student"){
        await getRoutineLocally(_info["department"] , "${_info["batch"]}${_info["section"]}", true);
      }
      else{
        await getRoutineLocally(_info["department"] , _info["ti"], false);
      }
    }

    hasUser ?
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context)=> MyHomePage()))
        :
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context)=> loginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: w*.1),
            child: Container(
              height: h>w? h*.3 : w*.3,
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          SizedBox(
            height: h*.02,
            width: w,
          ),
          Text(
            "DAILY DIU",
            style: TextTittleStyle,
          )
        ],
      ),
    );
  }
}
