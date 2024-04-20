import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNavbar extends StatefulWidget {
  final VoidCallback func;

  const BottomNavbar({super.key, required this.func});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    final items = <Widget>[
      Icon(FontAwesomeIcons.leanpub, size: 25,),
      Icon(FontAwesomeIcons.chalkboardUser, size: 25,),
      Icon(Icons.home, size: 32,),
      Icon(FontAwesomeIcons.calendarCheck, size: 25,),
      Icon(FontAwesomeIcons.bell, size: 25,),
    ];


    return CurvedNavigationBar(
      height: h*.065,
      index: PageIndex,
      items: items,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      color: Colors.blueAccent,
      backgroundColor: Colors.transparent,
      buttonBackgroundColor: Colors.blueAccent,
      onTap: (value){
        PageIndex = value;
        widget.func();
      },
    );
  }
}
