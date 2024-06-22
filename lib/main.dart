import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:diu_student/config/theme/Themes.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/features/blc/presentation/pages/blc_main.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_routine.dart';
import 'package:diu_student/features/home/data/models/user_info.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/login%20system/presentation/pages/email_varification_page.dart';
import 'package:diu_student/features/login%20system/presentation/pages/signup_page.dart';
import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:diu_student/features/notes/notes.dart';
import 'package:diu_student/features/notice%20board/noticeBoard.dart';
import 'package:diu_student/features/routine/presentation/pages/routine_main.dart';
import 'package:diu_student/firebase_options.dart';
import 'package:diu_student/injection_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'features/home/data/data_sources/local/local_user_info.dart';
import 'features/home/data/repository/routine_repo_implement.dart';
import 'features/home/data/repository/user_info_store.dart';
import 'features/routine/data/repository/time_repository_implement.dart';
import 'core/resources/information_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  bool hasUser = user != null;
  await Hive.initFlutter();
  var box = await Hive.openBox("routine_box");
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
    getUserInfo();
    if(_info["user"] == "Student"){
      await getRoutineLocally("${_info["batch"]}${_info["section"]}", true);
    }
    else{
      await getRoutineLocally(_info["ti"], false);
    }
  }


  runApp( MyApp(hasUser: hasUser,));
}

class MyApp extends StatelessWidget {
  final bool hasUser;
  const MyApp({super.key, required this.hasUser});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          home: hasUser ? MyHomePage() : loginScreen());
          // home:  EmailVerifyScreen());


  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 2);

    List<Widget> _screens = [
      notePage(),
      blcPage(),
      homePage(),
      RoutinePage(),
      noticeBoardPage(),
    ];

    List<PersistentBottomNavBarItem> _navBarItems = [
      PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.leanpub,
            size: 20,
          ),
          title: "Notes",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey),
      PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.chalkboardUser,
            size: 20,
          ),
          title: "BLC",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey),
      PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.house, size: 20),
          title: "Home",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey),
      PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.calendarCheck,
            size: 20,
          ),
          title: "Routine",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey),
      PersistentBottomNavBarItem(
          icon: Icon(
            FontAwesomeIcons.bell,
            size: 20,
          ),
          title: "Notice",
          activeColorPrimary: Colors.blue,
          inactiveColorPrimary: Colors.blueGrey),
    ];

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarItems,
      confineInSafeArea: true,
      backgroundColor: Colors.blue.shade50,
      // Default is Colors.blue.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10),
        colorBehindNavBar: Colors.blue.shade50,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}
