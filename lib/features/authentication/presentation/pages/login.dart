import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_event.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_state.dart';
import 'package:diu_student/features/authentication/presentation/pages/signup_page.dart';
import 'package:diu_student/features/home/presentation/state/home_bloc.dart';
import 'package:diu_student/features/home/presentation/state/home_event.dart';
import 'package:diu_student/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/textStyle.dart';
import 'email_varification_page.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  late TextEditingController emailController, passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BlocConsumer(
        bloc: context.read<AuthBloc>(),
        buildWhen: (previous, current) =>
            current is! AuthActionState && current is AuthLogin,
        listener: ((context, state) async {
          if (state is AuthLoginSucceed) {
            context.read<HomeBloc>().add(HomeInitialEvent());
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
          } else if (state is AuthLoginFailed) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          } else if (state is AuthLoginNotVerified) {
            await FirebaseAuth.instance.currentUser
                ?.sendEmailVerification()
                .then(
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
          } else if (state is AuthLoginForgotPassword) {
            showDialog(
              context: context,
              builder: (context) => ShowAlertMessage(
                text: state.message,
              ),
            );
          }
        }),
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              body: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: h > w ? h * .15 : w * .15,
                      ),

                      const SizedBox(height: 20),
                      Text(
                        "Welcome Back!",
                        style: TextTittleStyle,
                      ),
                      const SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(27, 95, 225, 0.3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ]),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Color(0xffeeeeee))),
                                ),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                    hintText: "E.g: softenge@diu.edu.bd",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Color(0xffeeeeee))),
                                ),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: const InputDecoration(
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
                              onPressed: () {
                                String email = emailController.text.trim();
                                context.read<AuthBloc>().add(
                                      AuthLoginForgotPasswordEvent(email),
                                    );
                              },
                              child: const Text('Forgot Password?'),
                            ),
                          ],
                        ),
                      ),
                      // Login button
                      context.read<AuthBloc>().state is AuthLoginLoading
                          ? const CupertinoActivityIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                String email = emailController.text.trim();
                                String pass = passwordController.text;
                                context.read<AuthBloc>().add(AuthLoginEvent(
                                      email: email,
                                      password: pass,
                                    ));
                              },
                              child: const Text('Login'),
                            ),
                      const SizedBox(height: 10),

                      // Create account button
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupPage()),
                          );
                        },
                        child: const Text(
                          'Don\'t have an account? Create Account.',
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
} // end line
