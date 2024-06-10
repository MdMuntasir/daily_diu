import 'package:diu_student/features/login%20system/login/login.dart';
import 'package:diu_student/features/login%20system/sign%20up/signup_student.dart';
import 'package:diu_student/features/login%20system/sign%20up/signup_teacher.dart';
import 'package:flutter/material.dart';
import 'customs/btnStyle.dart';
import 'customs/textStyle.dart';

class OpenLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
              SizedBox(height: 20),
              // Welcome text
              Text(
                'Welcome.',
                style: TextTittleStyle,
              ),
              SizedBox(height: 30),
              // Sign Up For Teacher button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signupTeacher()));
                },
                style: buttonStyle,
                child: Text(
                  'Create account for Teacher',
                  style: buttonTextStyle,
                ),
              ),
              SizedBox(height: 20),
              // Sign Up For Student button
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => signupStudent()));
                },
                style: buttonStyle,
                child: Text(
                  'Create account for Student',
                  style: buttonTextStyle,
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => loginScreen()),
                  );
                },
                child: Text(
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
    );
  }
}
