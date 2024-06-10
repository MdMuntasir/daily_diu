import 'package:diu_student/features/login%20system/login/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../customs/btnStyle.dart';
import '../customs/customWidgets.dart';
import '../customs/textStyle.dart';

class signupStudent extends StatefulWidget {
  @override
  State<signupStudent> createState() => _signupStudentState();
}

class _signupStudentState extends State<signupStudent> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();

  // get textTitleStyle => null;

  void _createAccount() {
    // Handle create account logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Logo
                Container(
                  height: 100,
                  // Ensure you have a logo.png in your assets folder
                  // child: Image.asset('assets/logo.png'),
                  // child: const FlutterLogo(size: 100),
                ),
                SizedBox(height: 20),
                // Welcome text
                Text(
                  'Welcome.',
                  style: TextTittleStyle,
                ),
                SizedBox(height: 30),
                // Custom Form
                CustomForm(
                  fields: [
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: batchController,
                      decoration: InputDecoration(
                        hintText: "Batch",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: sectionController,
                      decoration: InputDecoration(
                        hintText: "Section",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: studentIdController,
                      decoration: InputDecoration(
                        hintText: "Student ID",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "E.g: softenge@diu.edu.bd",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){},
                  child: Text('Create Account'),
                ),
                SizedBox(height: 15),
                // Create account link
                TextButton(
                  onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => loginScreen()));
                  },
                  child: Text(
                    'Already have an account? Login Now.',
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
}
