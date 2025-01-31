import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/navbar/presentation/pages/passChangePage.dart';
import 'package:diu_student/features/navbar/presentation/widgets/edit_student.dart';
import 'package:diu_student/features/navbar/presentation/widgets/edit_teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../home/data/data_sources/local/local_routine.dart';
import '../../../home/data/data_sources/local/local_user_info.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController batchController = TextEditingController();
  final TextEditingController sectionController = TextEditingController();
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController teacherInitialController =
      TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();
  bool isLoading = false;
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    batchController.dispose();
    sectionController.dispose();
    studentIdController.dispose();
    teacherInitialController.dispose();
    departmentController.dispose();
    facultyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h > w;
    bool isStudent = studentInfo.user != null;

    Future<void> _submit() async {
      String name = nameController.text.trim();
      String batch = batchController.text;
      String section = sectionController.text.trim().toUpperCase();
      String studentId = studentIdController.text;
      String teacherInitial =
          teacherInitialController.text.trim().toUpperCase();
      String faculty = facultyController.text;
      String dept = departmentController.text;
      String password = passwordController.text;

      setState(() {
        isLoading = true;
      });

      if (password.isNotEmpty) {
        if (faculty.isNotEmpty && dept.isEmpty) {
          showDialog(
              context: context,
              builder: (context) =>
                  ShowAlertMessage(text: "Choose department"));
        } else {
          if (isStudent) {
            if (password == studentInfo.password) {
              try {
                await FirebaseFirestore.instance
                    .collection("student")
                    .doc(studentInfo.docID)
                    .update({
                  'name': name.isNotEmpty ? name : studentInfo.name,
                  'batch': batch.isNotEmpty ? batch : studentInfo.batch,
                  'section': section.isNotEmpty ? section : studentInfo.section,
                  'studentID':
                      studentId.isNotEmpty ? studentId : studentInfo.studentID,
                  'faculty': faculty.isNotEmpty ? faculty : studentInfo.faculty,
                  'department': dept.isNotEmpty ? dept : studentInfo.department,
                }).then(
                  (value) async {
                    await getUserInfo();
                    await getRoutineLocally(studentInfo.department,
                        "${studentInfo.batch}${studentInfo.section}", true);

                    nameController.clear();
                    batchController.clear();
                    sectionController.clear();
                    studentIdController.clear();
                    facultyController.clear();
                    departmentController.clear();
                    passwordController.clear();

                    showDialog(
                        context: context,
                        builder: (context) => const ShowAlertMessage(
                              text: "Account has been successfully updated",
                              hasSucceed: true,
                            ));
                  },
                );
              } on FirebaseException catch (e) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ShowAlertMessage(text: e.code.toString()));
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ShowAlertMessage(text: "Wrong password"));
            }
          } else {
            if (password == teacherInfo.password) {
              try {
                await FirebaseFirestore.instance
                    .collection("teacher")
                    .doc(teacherInfo.docID)
                    .update({
                  'name': name.isNotEmpty ? name : teacherInfo.name,
                  'ti': teacherInitial.isNotEmpty
                      ? teacherInitial
                      : teacherInfo.ti,
                  'faculty': faculty.isNotEmpty ? faculty : teacherInfo.faculty,
                  'department': dept.isNotEmpty ? dept : teacherInfo.department,
                }).then(
                  (value) async {
                    await getUserInfo();
                    await getRoutineLocally(
                        teacherInfo.department, teacherInfo.ti, false);

                    nameController.clear();
                    teacherInitialController.clear();
                    facultyController.clear();
                    departmentController.clear();
                    passwordController.clear();

                    showDialog(
                        context: context,
                        builder: (context) => const ShowAlertMessage(
                              text: "Account has successfully been updated",
                              hasSucceed: true,
                            ));
                  },
                );
              } on FirebaseException catch (e) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ShowAlertMessage(text: e.code.toString()));
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) =>
                      ShowAlertMessage(text: "Wrong password"));
            }
          }
        }
      } else {
        showDialog(
            context: context,
            builder: (context) =>
                ShowAlertMessage(text: "Enter your password"));
      }

      setState(() {
        isLoading = false;
      });
    }

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: h * .05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(FontAwesomeIcons.xmark))
              ],
            ),
          ),
          SizedBox(
            height: h * .02,
          ),
          SizedBox(
            width: w * .8,
            child: Text(
              "Only update fields that need to be modified, leave blank the other fields. Providing your password is mandatory to continue. ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: h * .03,
          ),
          isStudent
              ? EditStudentProfile(
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: nameController,
                  batchController: batchController,
                  sectionController: sectionController,
                  studentIdController: studentIdController,
                  facultyController: facultyController,
                  departmentController: departmentController,
                )
              : EditTeacherProfile(
                  emailController: emailController,
                  passwordController: passwordController,
                  nameController: nameController,
                  teacherInitialController: teacherInitialController,
                  facultyController: facultyController,
                  departmentController: departmentController,
                ),
          SizedBox(
            height: h * .01,
          ),
          SizedBox(
            width: horizontal ? w * .85 : h * .85,
            child: isLoading
                ? const CupertinoActivityIndicator()
                : ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                        elevation: const WidgetStatePropertyAll(8),
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.greenAccent.shade100)),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Madimi",
                      ),
                    ),
                  ),
          ),
          SizedBox(
            height: h * .02,
          ),
          SizedBox(
            width: horizontal ? w * .85 : h * .85,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PassChangePage()));
              },
              style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(8),
                  backgroundColor: WidgetStatePropertyAll(Colors.white)),
              child: const Text(
                "Change Password",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Madimi",
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
