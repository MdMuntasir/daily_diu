import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/features/home/presentation/pages/homePage.dart';
import 'package:diu_student/features/login%20system/firebase_auth/firebase_auth_services.dart';
import 'package:diu_student/features/login%20system/presentation/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'customWidgets.dart';
import 'textStyle.dart';



class signupStudent extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPassController;
  final TextEditingController nameController;
  final TextEditingController batchController;
  final TextEditingController sectionController;
  final TextEditingController studentIdController;
  const signupStudent({super.key, required this.emailController, required this.passwordController, required this.nameController, required this.batchController, required this.sectionController, required this.studentIdController, required this.confirmPassController});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomForm(
        fields: [
          TextField(
            controller: nameController,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]'))],
            decoration: const InputDecoration(
              hintText: "Name",
              counterText: "",
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
          CustomTextField(
            controller: batchController,
            hintText: "Batch;   Ex: 41",
            isDigit: true,
            maxLen: 2,
          ),
          CustomTextField(
            controller: sectionController,
            hintText: "Section;   Ex: N",
            maxLen: 2,
          ),
          TextField(
            controller: studentIdController,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9-]'))],
            decoration: const InputDecoration(
              hintText: "Student ID;   Ex: 232-35-689",
              counterText: "",
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
