import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/home/data/models/user_info.dart';
import 'package:diu_student/features/login%20system/presentation/pages/email_varification_page.dart';
import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:diu_student/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../home/data/data_sources/local/local_routine.dart';
import '../../../home/data/data_sources/local/local_user_info.dart';
import '../../../home/data/repository/user_info_store.dart';
import '../../../home/presentation/pages/homePage.dart';
import '../../firebase_auth/firebase_auth_services.dart';
import '../widgets/multi_chooser.dart';
import '../widgets/signup_student.dart';
import '../widgets/signup_teacher.dart';
import '../widgets/single_chooser.dart';
import '../widgets/textStyle.dart';
import '../widgets/toogler.dart';


class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isToggled = false;
  bool isLoading = false;
  double formHeight = 0;
  Duration duration = Duration(milliseconds: 300);
  double position = .045, changePose = 0;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController teacherInitialController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();

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
    departmentController.dispose();
    facultyController.dispose();
    confirmPassController.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    formHeight = isToggled ?  h* .08 * 5.5 : h* .08 * 7.5;
    changePose = isToggled ? w : 0;

    void _toogle(){
      setState(() {
        isToggled = !isToggled;
      });
    }


    void createAccount() async{
      String name = nameController.text.trim();
      String batch = batchController.text;
      String section = sectionController.text.toUpperCase();
      String studentId = studentIdController.text;
      String teacherInitial = teacherInitialController.text.toUpperCase();
      String faculty = facultyController.text;
      String dept = departmentController.text;
      String email = emailController.text.trim().toLowerCase();
      String password = passwordController.text;
      String confirmPass = confirmPassController.text;


      setState(() {
        isLoading = true;
      });

      if(!isToggled){
        if(
            name.isEmpty || batch.isEmpty || section.isEmpty ||
                studentId.isEmpty || faculty.isEmpty || dept.isEmpty ||
                email.isEmpty || password.isEmpty || confirmPass.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
              snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Fill all the information to continue"))
          );
          
        }

        else{
          if(confirmPass == password){
            if(email.endsWith("@diu.edu.bd")){
             password.length >= 8 ? await _studentSignup() :
             ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Enter a strong password")));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Enter a valid DIU mail")));
            }

          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Password didn't match")));
          }
        }
      }

      else{
        if(
        name.isEmpty || teacherInitial.isEmpty || faculty.isEmpty || dept.isEmpty ||
            email.isEmpty || password.isEmpty || confirmPass.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Fill all the information to continue")));
        }

        else{
          if(confirmPass == password){
            if(email.endsWith("@diu.edu.bd")){
              password.length >= 8 ? await _teacherSignup() :
              ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Enter a strong password")));

            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Enter a valid DIU mail")));
            }
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text("Password didn't match")));
          }
        }
      }

      setState(() {
        isLoading = false;
      });
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



                SizedBox(height: h*.015),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SingleChooser(
                      map: Faculty_Info,
                      controller: facultyController,
                      title: "Faculty",
                      func: () {setState(() {});},),
                    SizedBox(width: w*.1,),
                    isToggled?
                    MultiChooser(
                      map: facultyController.text == "" ? {} : Faculty_Info[facultyController.text],
                      controller: departmentController,
                      title: "Department",
                    ):
                    SingleChooser(
                      map: facultyController.text == "" ? {} : Faculty_Info[facultyController.text],
                      controller: departmentController,
                      title: "Department",
                      func: () {},),
                  ],
                ),



                SizedBox(height: h*.015),
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
                              confirmPassController: confirmPassController,
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
                              confirmPassController: confirmPassController,
                              nameController: nameController,
                              teacherInitialController: teacherInitialController,)
                      )
                      ],
                  )

                ),

                SizedBox(height: h*.001),
                isLoading ?
                const CupertinoActivityIndicator()
                    : ElevatedButton(
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
    String name = nameController.text.trim();
    String batch = batchController.text;
    String section = sectionController.text.trim().toUpperCase();
    String studentId = studentIdController.text;
    String faculty = facultyController.text;
    String dept = departmentController.text;
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text;

    UserCredential? user;
    try {
      user = await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        CollectionReference collRef = FirebaseFirestore.instance.collection('student');
        Map<String,dynamic> userData = {
          'user' : "Student",
          'name': name,
          'batch': batch,
          'section': section,
          'studentID': studentId,
          'faculty' : faculty,
          'department' : dept,
          'email': email,
          'verified' : false
        };
        collRef.add(userData).then((doc) async {
          await _auth.currentUser?.sendEmailVerification().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EmailVerifyScreen(isStudent: true, docId: doc.id,)));
          },);
        },);

        // await getRoutineLocally("${userData["batch"]}${userData["section"]}", true);
        // StoreUserInfo(StudentInfoModel.fromJson(userData), true);
        // getUserInfo();


        // ScaffoldMessenger.of(context).showSnackBar(
        //     snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
        //     SnackBar(content: Text("Successfully Signed Up")));


        return null;
      });
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text(e.code.toString())));
    }

  }



  Future<void> _teacherSignup() async {

    String name = nameController.text.trim();
    String teacherInitial = teacherInitialController.text.trim().toUpperCase();
    String faculty = facultyController.text;
    String dept = departmentController.text;
    String email = emailController.text.trim().toLowerCase();
    String password = passwordController.text;

    
    UserCredential? user;
    try {
      
      user = await _auth.createUserWithEmailAndPassword( email: email, password: password).then((doc) async {
        CollectionReference collRef = FirebaseFirestore.instance.collection('teacher');
        Map<String,dynamic> userData = {
          
          'user' : "Teacher",
          'name': name,
          'ti': teacherInitial,
          'faculty' : faculty,
          'department' : dept,
          'email': email,
          'verified' : false
        };
        collRef.add(userData).then((doc) async {
          await _auth.currentUser?.sendEmailVerification().then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => EmailVerifyScreen(isStudent: false, docId: doc.id,)));
          },);
        },);


        // await getRoutineLocally(userData["ti"], false);
        // StoreUserInfo(TeacherInfoModel.fromJson(userData), false);
        // getUserInfo();



        // ScaffoldMessenger.of(context).showSnackBar(
        //     snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
        //     SnackBar(content: Text("Successfully Signed Up")));



        return null;
      },);
    }
    on FirebaseAuthException catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
            snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
            SnackBar(content: Text(e.code.toString())));
    }

  }

}
