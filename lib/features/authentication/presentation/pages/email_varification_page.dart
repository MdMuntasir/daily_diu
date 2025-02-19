import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_event.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_state.dart';
import 'package:diu_student/features/authentication/presentation/pages/signup_page.dart';
import 'package:diu_student/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EmailVerifyScreen extends StatefulWidget {
  final UserEntity user;

  const EmailVerifyScreen({
    super.key,
    required this.user,
  });

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool initialized = false;
  bool verified = false;
  late Timer _timer;

  @override
  void initState() {
    Bloc bloc = context.read<AuthBloc>();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (!initialized) {
        await FirebaseFirestore.instance
            .collection(widget.user.user == "Student" ? "student" : "teacher")
            .doc(widget.user.docID)
            .update({'docID': widget.user.docID});

        initialized = true;
      }

      _auth.currentUser?.reload();
      if (_auth.currentUser!.emailVerified) {
        timer.cancel();
        if (context.mounted) {
          bloc.add(AuthVerifyEvent(
            user: widget.user,
          ));
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    void _resendMail() async {
      await _auth.currentUser?.sendEmailVerification().then(
        (value) {
          if (context.mounted) {
            showDialog(
                context: context,
                builder: (context) =>
                    const ShowAlertMessage(text: "Email has been Sent"));
          }
        },
      );
    }

    void _goBack() async {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignupPage()));
    }

    return BlocConsumer(
        bloc: context.read<AuthBloc>(),
        buildWhen: (previous, current) => current is AuthVerification,
        listener: (context, state) {
          if (state is AuthVerifiedState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MyApp()));
          } else if (state is AuthVerificationFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: w * .1),
              height: h,
              width: w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.envelope,
                    size: 120,
                    color: Colors.red.shade300,
                  ),
                  SizedBox(
                    height: h * .05,
                  ),
                  const Text(
                    "Verify Email",
                    style: TextStyle(
                        fontSize: 38,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  const Text(
                    "A verification email has been sent to your email address. Please follow the link attached with the mail to verify your email.",
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: h * .02,
                  ),
                  State is AuthVerificationLoading
                      ? const Text("Redirecting to Homepage...")
                      : TextButton(
                          onPressed: _goBack,
                          child: SizedBox(
                            width: w * .5,
                            height: h * .05,
                            child: const Center(
                              child: ListTile(
                                leading: Icon(
                                  Icons.arrow_back,
                                  color: Colors.blue,
                                ),
                                title: Text(
                                  "Signup Page",
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            ),
                          )),
                  State is AuthVerificationLoading
                      ? const CupertinoActivityIndicator()
                      : TextButton(
                          onPressed: _resendMail,
                          child: SizedBox(
                            width: w * .5,
                            height: h * .04,
                            child: const ListTile(
                              leading: Icon(
                                Icons.refresh,
                                color: Colors.green,
                              ),
                              title: Text(
                                "Resend mail",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          )),
                ],
              ),
            ),
          );
        });
  }
}
