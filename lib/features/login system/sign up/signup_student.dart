import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/login%20system/firebase_auth/firebase_auth_services.dart';
import 'package:diu_student/features/login%20system/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/customWidgets.dart';
import '../widgets/textStyle.dart';



class signupStudent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController batchController;
  final TextEditingController sectionController;
  final TextEditingController studentIdController;
  const signupStudent({super.key, required this.emailController, required this.passwordController, required this.nameController, required this.batchController, required this.sectionController, required this.studentIdController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomForm(
        fields: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(
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
        ],
      ),

    );
  }
}
