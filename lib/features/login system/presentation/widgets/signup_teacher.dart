import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'customWidgets.dart';
import 'textStyle.dart';




class signupTeacher extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final TextEditingController nameController;
  final TextEditingController teacherInitialController;
  const signupTeacher({super.key, required this.emailController, required this.passwordController, required this.nameController, required this.teacherInitialController, required this.confirmPassController,});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomForm(
        fields: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: "Name",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
          CustomTextField(
            controller: teacherInitialController,
            hintText: "Teacher Initial, Ex: IM",
            maxLen: 4,
          ),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: "E.g: softenge@diu.edu.bd",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.endsWith('@diu.edu.bd')) {
                return 'Please enter a valid DIU email';
              }
              return null;
            },
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
          TextField(
            controller: confirmPassController,
            decoration: InputDecoration(
              hintText: "Confirm Password",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
