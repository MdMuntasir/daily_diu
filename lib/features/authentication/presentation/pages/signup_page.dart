import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/core/util/model/user_info.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_event.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/multi_chooser.dart';
import '../widgets/signup_student.dart';
import '../widgets/signup_teacher.dart';
import '../widgets/single_chooser.dart';
import '../widgets/toogler.dart';
import 'email_varification_page.dart';
import 'login.dart';

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
  final TextEditingController teacherInitialController =
      TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController facultyController = TextEditingController();

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
    confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    formHeight = isToggled ? h * .08 * 5.5 : h * .08 * 7.5;
    changePose = isToggled ? w : 0;

    void toggleFunc() {
      setState(() {
        isToggled = !isToggled;
      });
    }

    return BlocConsumer(
        bloc: context.read<AuthBloc>(),
        buildWhen: (prev, current) =>
            current is! AuthActionState && current is AuthSignUp,
        listener: (context, state) async {
          if (state is AuthSignUpSucceed) {
            await _auth.currentUser?.sendEmailVerification().then(
              (_) {
                if (context.mounted) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailVerifyScreen(
                                user: state.user,
                                // isStudent: state.user.user == "Student",
                                // docId: state.user.docID!,
                              )));
                }
              },
            );
          } else if (state is AuthSignUpFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                snackBarAnimationStyle:
                    AnimationStyle(duration: const Duration(seconds: 2)),
                SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
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
                      SizedBox(height: h * .03),
                      SizedBox(
                        height: 90,
                        child: Image.asset('assets/images/logo.png'),
                        // child: const FlutterLogo(size: 100),
                      ),
                      SizedBox(height: h * .01),
                      const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                          fontFamily: "Takota",
                        ),
                      ),
                      SizedBox(height: h * .02),
                      Toogler(
                        toggled: isToggled,
                        func: toggleFunc,
                      ),
                      SizedBox(height: h * .015),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SingleChooser(
                            map: Faculty_Info,
                            controller: facultyController,
                            title: "Faculty",
                            func: () {
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            width: w * .1,
                          ),
                          isToggled
                              ? MultiChooser(
                                  map: facultyController.text == ""
                                      ? {}
                                      : Faculty_Info[facultyController.text],
                                  controller: departmentController,
                                  title: "Department",
                                )
                              : SingleChooser(
                                  map: facultyController.text == ""
                                      ? {}
                                      : Faculty_Info[facultyController.text],
                                  controller: departmentController,
                                  title: "Department",
                                  func: () {},
                                ),
                        ],
                      ),
                      SizedBox(height: h * .015),
                      AnimatedContainer(
                          duration: duration,
                          height: formHeight,
                          width: w,
                          child: Stack(
                            children: [
                              AnimatedPositioned(
                                  duration: duration,
                                  left: w * position - changePose,
                                  child: signupStudent(
                                      emailController: emailController,
                                      passwordController: passwordController,
                                      confirmPassController:
                                          confirmPassController,
                                      nameController: nameController,
                                      batchController: batchController,
                                      sectionController: sectionController,
                                      studentIdController:
                                          studentIdController)),
                              AnimatedPositioned(
                                  duration: duration,
                                  left: -changePose + w * position + w,
                                  child: signupTeacher(
                                    emailController: emailController,
                                    passwordController: passwordController,
                                    confirmPassController:
                                        confirmPassController,
                                    nameController: nameController,
                                    teacherInitialController:
                                        teacherInitialController,
                                  ))
                            ],
                          )),
                      state is AuthSignUpLoading
                          ? const CupertinoActivityIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                String name = nameController.text.trim();
                                String batch = batchController.text;
                                String section =
                                    sectionController.text.toUpperCase();
                                String studentId = studentIdController.text;
                                String teacherInitial =
                                    teacherInitialController.text.toUpperCase();
                                String faculty = facultyController.text;
                                String dept = departmentController.text;
                                String email =
                                    emailController.text.trim().toLowerCase();
                                String password = passwordController.text;
                                String confirmPass = confirmPassController.text;

                                context.read<AuthBloc>().add(AuthSignUpEvent(
                                      user: UserModel(
                                        user: isToggled ? "Teacher" : "Student",
                                        name: name,
                                        batch: batch,
                                        section: section,
                                        studentID: studentId,
                                        ti: teacherInitial,
                                        faculty: faculty,
                                        department: dept,
                                        email: email,
                                        password: password,
                                      ),
                                      confirmPassword: confirmPass,
                                    ));
                              },
                              child: const Text('Create Account'),
                            ),
                      SizedBox(height: h * .001),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const loginScreen()),
                          );
                        },
                        child: const Text(
                          'Already have an account? Login Now!',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
