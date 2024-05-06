import 'package:diu_student/config/theme/Themes.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/features/blc/presentation/pages/blc_main.dart';
import 'package:diu_student/features/home/homePage.dart';
import 'package:diu_student/features/login%20system/login/login.dart';
import 'package:diu_student/features/notes/notes.dart';
import 'package:diu_student/features/notice%20board/noticeBoard.dart';
import 'package:diu_student/features/routine/presentation/pages/routine_main.dart';
import 'package:diu_student/features/routine/presentation/pages/student_routine.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_bloc.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_event.dart';
import 'package:diu_student/firebase_options.dart';
import 'package:diu_student/injection_container.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'features/routine/data/repository/time_repository_implement.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentRoutineBloc>(
      create: (context) => sl()..add(getStudentRoutine()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const loginScreen(),
      ),
    );
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

    PersistentTabController _controller = PersistentTabController(initialIndex: 2);

    List<Widget> _screens = [
      notePage(),
      blcPage(),
      homePage(),
      RoutinePage(),
      noticeBoardPage(),
    ];
    
    
    List<PersistentBottomNavBarItem> _navBarItems = [
      PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.leanpub,),
        title: "Notes",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60
      ),
      PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.chalkboardUser),
        title: "BLC",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60
      ),
      PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.calendarCheck,),
        title: "Routine",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60
      ),
      PersistentBottomNavBarItem(
          icon: Icon(FontAwesomeIcons.bell,),
        title: "Notice",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white60
      ),

    ];


    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarItems,
      confineInSafeArea: true,
      backgroundColor: Colors.blueAccent, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style3, // Choose the nav bar style with this property.
    );
  }
}

