import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:diu_student/core/util/widgets/error_screen.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:diu_student/features/login%20system/presentation/widgets/textStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'core/remote info/get_main_kamla_info.dart';
import 'core/resources/information_repository.dart';
import 'features/home/data/data_sources/local/local_routine.dart';
import 'features/home/data/data_sources/local/local_user_info.dart';
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
    Timer.periodic(Duration(seconds: 1), (_) async {
      final _checkConnection = await Connectivity().checkConnectivity();
      Online = _checkConnection.contains(ConnectivityResult.mobile) ||
          _checkConnection.contains(ConnectivityResult.wifi);
    });
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    await Hive.initFlutter;
    Box routineBox = await Hive.openBox("routine_box");
    Box resultBox = await Hive.openBox("Result");

    User? pre_user = FirebaseAuth.instance.currentUser;
    bool hasUser = pre_user != null;

    android_info = await DeviceInfoPlugin().androidInfo;

    if (hasUser) {
      User user = FirebaseAuth.instance.currentUser!;
      var _userInfo = Hive.box("routine_box").get("UserInfo");

      if (_userInfo == null || _userInfo["verified"] == false) {
        hasUser = false;
      }
    }

    if (hasUser) {
      Box _box = Hive.box("routine_box");
      Map _info = _box.get("UserInfo");

      await getApiLink(); // Updates API link from backend
      await getUserInfo(); // Gets User information

      //sets user
      UserRole = _info["user"];

      // Gets routine according user information
      if (_info["user"] == "Student") {
        await getRoutineLocally(
            _info["department"], "${_info["batch"]}${_info["section"]}", true);
      } else {
        await getRoutineLocally(_info["department"], _info["ti"], false);
      }
    }

    hasUser
        ? Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const homePage()))
        : Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const loginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: h * .02,
        children: [
          Lottie.asset("assets/lottie/Loading1.json", height: h * .3),
          SizedBox(
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
