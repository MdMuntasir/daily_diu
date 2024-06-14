import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/features/login%20system/login/login.dart';
import 'package:diu_student/features/login%20system/sign%20up/signup_student.dart';
import 'package:diu_student/features/login%20system/sign%20up/signup_teacher.dart';
import 'package:diu_student/features/login%20system/widgets/textStyle.dart';
import 'package:diu_student/features/login%20system/widgets/toogler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home/presentation/pages/homePage.dart';
import 'firebase_auth/firebase_auth_services.dart';


class OpenLoginPage extends StatefulWidget {
  @override
  State<OpenLoginPage> createState() => _OpenLoginPageState();
}

class _OpenLoginPageState extends State<OpenLoginPage> {
  bool isToggled = false;
  double formHeight = 0;
  Duration duration = Duration(milliseconds: 300);
  double position = .045, changePose = 0;

  final firebaseAuthService _auth = firebaseAuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController teacherInitialController = TextEditingController();

  @override
  void dispose()
  {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    batchController.dispose();
    sectionController.dispose();
    studentIdController.dispose();
    teacherInitialController.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    formHeight = isToggled ?  h*.365 : h*.525;
    changePose = isToggled ? w : 0;

    void _toogle(){
      setState(() {
        isToggled = !isToggled;
      });
    }

    void createAccount(){

    }




    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Logo
                Container(
                  height: 100,
                  // child: Image.asset('assets/logo.png'),
                  child: const FlutterLogo(size: 100),
                ),
                SizedBox(height: h*.03),
                // Welcome text
                Text(
                  'Welcome.',
                  style: TextTittleStyle,
                ),
                SizedBox(height: h*.02),
                Toogler(toggled: isToggled,func: _toogle,),
                SizedBox(height: h*.03),
                AnimatedContainer(
                    duration: duration,
                  height: formHeight,
                  width: w,
                  child: Stack(
                    children: [
                      AnimatedPositioned(
                          duration: duration,
                          left: w*position -changePose,
                          child: signupStudent(
                              emailController: emailController,
                              passwordController: passwordController,
                              nameController: nameController,
                              batchController: batchController,
                              sectionController: sectionController,
                              studentIdController: studentIdController)
                      ),
                      AnimatedPositioned(
                          duration: duration,
                          left: -changePose + w*position + w,
                          child: signupTeacher(
                              emailController: emailController,
                              passwordController: passwordController,
                              nameController: nameController,
                              teacherInitialController: teacherInitialController)
                      )
                      ],
                  )

                ),

                SizedBox(height: h*.001),
                ElevatedButton(
                  onPressed: createAccount,
                  child: Text('Create Account'),
                ),
                SizedBox(height: h*.01),

                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => loginScreen()),
                    );
                  },
                  child: const Text(
                    'Already have an account? Login Now!',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _studentSignup() async {
    String name = nameController.text;
    String batch = batchController.text;
    String section = sectionController.text;
    String studentId = studentIdController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {

      CollectionReference collRef = FirebaseFirestore.instance.collection('student');
      collRef.add({
        'name': name,
        'batch': batch,
        'section': section,
        'studentID': studentId,
        'email': email,
        'password': password,
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homePage()));
    }
    else
    {
      log("Error Occurred!");
    }

  }



  Future<void> _teacherSignup() async {
    String name = nameController.text;
    String teacherInitial = teacherInitialController.text;
    String email = emailController.text;
    String password = passwordController.text;

    User? user = await _auth.signUpWithEmailAndPassword(email, password);

    if (user != null) {

      CollectionReference collRef = FirebaseFirestore.instance.collection('Teacher');
      collRef.add({
        'name': name,
        'ti': teacherInitial,
        'email': email,
        'password': password,
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => homePage()));
    }
    else
    {
      log("Error Occurred!");
    }

  }

}
