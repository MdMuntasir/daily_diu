import 'package:diu_student/core/widgets/bottom_navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentRoutine extends StatelessWidget {
  const StudentRoutine({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
              tag: "Student", child: Text(
              "Student",
            style: TextStyle(
                fontSize: 50,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold
            ),
          )),
          SizedBox(height: h*.1,width: w,)
        ],
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
