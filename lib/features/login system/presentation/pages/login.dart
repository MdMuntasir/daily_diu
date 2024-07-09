import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_user_info.dart';
import 'package:diu_student/features/home/data/models/user_info.dart';
import 'package:diu_student/features/home/data/repository/user_info_store.dart';
import 'package:diu_student/features/login%20system/firebase_auth/firebase_auth_services.dart';
import 'package:diu_student/features/login%20system/presentation/pages/signup_page.dart';
import 'package:diu_student/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../home/data/data_sources/local/local_routine.dart';
import '../widgets/textStyle.dart';


class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isLoading = false;
  late TextEditingController emailController, passwordController;

  // <----- to hide keyboard ----->

  late FocusNode _focusNode; // FocusNode instance variable here

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Disposing the FocusNode instance
    // emailController.dispose();
    // passwordController.dispose();
    emailController.dispose();
    passwordController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  // <----- to hide keyboard ----->

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        // to hide keyboard
        FocusScope.of(context).requestFocus(_focusNode);
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo here
                

                Image.asset(
                    "assets/images/logo.png",
                  height: h>w ? h*.15 : w*.15,
                ),

                SizedBox(height: 20),
                // Welcome text
                Text(
                  "Welcome Back!",
                  style: TextTittleStyle,
                ),
                SizedBox(height: 20),
                // Email field
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'E.g: softenge@diu.edu.bd',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(27, 95, 225, 0.3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffeeeeee))),
                          ),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: "E.g: softenge@diu.edu.bd",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xffeeeeee))),
                          ),
                          child: TextField(
                            controller: passwordController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                            ),
                            obscureText: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Forgot password text button
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: _forgotPass,
                        child: Text('Forgot Password?'),
                      ),
                    ],
                  ),
                ),
                // Login button
                isLoading ?
                    const CupertinoActivityIndicator()
                    : ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                ),
                SizedBox(height: 10),

                // Create account button
                TextButton(
                  onPressed: _CreateAccount,
                  child: Text(
                    'Don\'t have an account? Create Account.',
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

  Future<void> _login()
    async {
      String email = emailController.text.trim();
      String pass = passwordController.text;


      setState(() {
        isLoading = true;
      });

      if(email.isNotEmpty && pass.isNotEmpty)
        {
          UserCredential? user;
          try {
            user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: pass).then((val) async {

              FirebaseFirestore _db = FirebaseFirestore.instance;

              final snapshot1 = await _db.collection("student").where("email", isEqualTo: email).get();
              final snapshot2 = await _db.collection("teacher").where("email", isEqualTo: email).get();

              if(snapshot1.docs.isNotEmpty){
                StudentInfoModel userData = snapshot1.docs.map((e) => StudentInfoModel.fromSnapshot(e)).single;

                await getRoutineLocally(userData.department,"${userData.batch}${userData.section}", true);
                StoreUserInfo(userData, true);
                await getUserInfo();

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }



              else{
                TeacherInfoModel userData = snapshot2.docs.map((e) => TeacherInfoModel.fromSnapshot(e)).single;

                await getRoutineLocally(userData.department,userData.ti, false);
                StoreUserInfo(userData, false);
                await getUserInfo();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              }


              return null;
            });
          }

          on FirebaseAuthException catch(e){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.code.toString())));
          }

        }
      else
        {
          showDialog(context: context, builder: (context) => const ShowAlertMessage(
            hasSucceed: false,
            text: "Fill all the information to continue",
          ),);
        }
      setState(() {
        isLoading = false;
      });
    }

  void _CreateAccount() {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignupPage()),
      );
    }


  void _forgotPass(){
    String email = emailController.text.trim();

    if(email != "" && email.endsWith("@diu.edu.bd")){
      try {

        FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {

              showDialog(context: context, builder: (context) => const ShowAlertMessage(
                hasSucceed: true,
                text: "Password reset email has been sent to your mail address",
              ),);
            },
        );


      }
      on FirebaseException catch(e){
        showDialog(context: context, builder: (context) => ShowAlertMessage(
          text: e.code.toString(),
        ));
      }
    }
    else{
      showDialog(context: context, builder: (context) => const ShowAlertMessage(
        text: "Enter a valid email address",
      ),);
    }
  }


} // end line
