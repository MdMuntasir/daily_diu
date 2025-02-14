import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/core/util/model/user_info.dart';
import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/navbar/presentation/pages/passChangePage.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_bloc.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_event.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_state.dart';
import 'package:diu_student/features/navbar/presentation/widgets/edit_student.dart';
import 'package:diu_student/features/navbar/presentation/widgets/edit_teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
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
  late UserEntity currentUser;

  @override
  void initState() {
    currentUser = AppUserCubit().currentUser(context.read<AppUserCubit>());
    super.initState();
  }

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
    bool isStudent = currentUser.user == "Student";

    return BlocConsumer(
        bloc: context.read<NavBloc>(),
        listener: (context, state) {
          if (state is EditProfileState) {
            String name = nameController.text.trim();
            String batch = batchController.text;
            String section = sectionController.text.trim().toUpperCase();
            String studentId = studentIdController.text;
            String teacherInitial =
                teacherInitialController.text.trim().toUpperCase();
            String faculty = facultyController.text;
            String dept = departmentController.text;
            String password = passwordController.text;

            if (password.isNotEmpty) {
              if (faculty.isNotEmpty && dept.isEmpty) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        const ShowAlertMessage(text: "Choose department"));
              } else {
                UserEntity modifiedUser = UserModel(
                  name: name,
                  batch: batch,
                  faculty: faculty,
                  department: dept,
                  ti: teacherInitial,
                  studentID: studentId,
                  section: section,
                );

                if (password == currentUser.password) {
                  nameController.clear();
                  batchController.clear();
                  sectionController.clear();
                  studentIdController.clear();
                  facultyController.clear();
                  departmentController.clear();
                  teacherInitialController.clear();
                  passwordController.clear();
                  context
                      .read<NavBloc>()
                      .add(EditProfileConfirmEvent(modifiedUser));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          const ShowAlertMessage(text: "Wrong password"));
                }
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) =>
                      const ShowAlertMessage(text: "Enter your password"));
            }
          } else if (state is EditProfileSucceed) {
            showDialog(
                context: context,
                builder: (context) => const ShowAlertMessage(
                      text: "Account has been successfully updated",
                      hasSucceed: true,
                    ));
          } else if (state is EditProfileFailed) {
            final String errorMessage = state.message == "No Internet"
                ? "No Internet Connection"
                : "An error occurred while updating your profile";
            showDialog(
                context: context,
                builder: (context) => ShowAlertMessage(
                      text: errorMessage,
                      hasSucceed: false,
                    ));
          }
        },
        builder: (context, state) {
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
                            context.read<NavBloc>().add(NavInitialEvent());
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(FontAwesomeIcons.xmark))
                    ],
                  ),
                ),
                SizedBox(
                  height: h * .02,
                ),
                SizedBox(
                  width: w * .8,
                  child: const Text(
                    "Update only the fields you want to change and leave the rest blank. To proceed, please enter your password.",
                    style: TextStyle(
                      fontSize: 16,
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
                        user: AppUserCubit()
                            .currentUser(context.read<AppUserCubit>()),
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
                        user: AppUserCubit()
                            .currentUser(context.read<AppUserCubit>()),
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
                  child: state is EditProfileLoadingState
                      ? const CupertinoActivityIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            context.read<NavBloc>().add(EditProfileEvent());
                          },
                          style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(8),
                              backgroundColor: WidgetStatePropertyAll(
                                  Colors.greenAccent.shade100)),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PassChangePage()));
                    },
                    style: const ButtonStyle(
                        elevation: WidgetStatePropertyAll(8),
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
        });
  }
}
