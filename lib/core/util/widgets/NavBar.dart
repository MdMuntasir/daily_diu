import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    void signOut(){
      showDialog(
          context: context,
          builder: (context) => CustomAlertBox(
              text: "Want to log out?",
              function: (){
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
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.exit_to_app_rounded),
            title: const Text(
              "Logout",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: signOut,
          )
        ],
      ),
    );
  }
}
