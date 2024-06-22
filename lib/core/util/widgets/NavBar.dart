import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import 'custom_alert_box.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    bool horizontal =  h>w;

    void signOut(){
      showDialog(
          context: context,
          builder: (context) => CustomAlertBox(
              text: "Want to log out?",
              function: (){
                Box _box = Hive.box("routine_box");
                _box.clear();
                FirebaseAuth.instance.signOut();


                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Logged Out'),)
                );

                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => loginScreen()));
              }
          ));
    }



    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: ListView(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      icon: Icon(FontAwesomeIcons.xmark))
                ],
              ),
            ),
            ListTile(
              titleAlignment: ListTileTitleAlignment.center,
              leading: Icon(Icons.exit_to_app_rounded, size: horizontal ? w*.08 : h*.08),
              title: Text(
                "Logout",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: w*.05),
              ),
              onTap: signOut,
            )
          ],
        ),
      ),
    );
  }
}
