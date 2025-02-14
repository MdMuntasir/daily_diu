import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_bloc.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_event.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_state.dart';
import 'package:diu_student/features/navbar/presentation/widgets/change_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resources/information_repository.dart';
import '../../../../core/util/widgets/show_message.dart';
import '../../../home/data/data_sources/local/local_user_info.dart';

class PassChangePage extends StatefulWidget {
  PassChangePage({super.key});

  @override
  State<PassChangePage> createState() => _PassChangePageState();
}

class _PassChangePageState extends State<PassChangePage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newPassController = TextEditingController();
  final TextEditingController confirmNewPassController =
      TextEditingController();
  User user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;

  // late UserEntity currentUser;
  late bool isStudent;

  // @override
  // void initState() {
  //   currentUser = AppUserCubit().currentUser(context.read<AppUserCubit>());
  //   isStudent = currentUser.user == "Student";
  //   super.initState();
  // }

  @override
  void dispose() {
    passwordController.dispose();
    newPassController.dispose();
    confirmNewPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h > w;
    UserEntity currentUser =
        AppUserCubit().currentUser(context.read<AppUserCubit>());
    isStudent = currentUser.user == "Student";

    return BlocConsumer(
        bloc: context.read<NavBloc>(),
        buildWhen: (previous, current) =>
            current is ChangePassword && current is! ChangePasswordActionState,
        listener: (context, state) {
          if (state is ChangePasswordState) {
            String pass = passwordController.text;
            String newPass = newPassController.text;
            String confirmNewPass = confirmNewPassController.text;

            if (pass.isNotEmpty &&
                newPass.isNotEmpty &&
                confirmNewPass.isNotEmpty) {
              if (newPassController.text == confirmNewPassController.text) {
                String tempPass = newPass;
                if (pass == currentUser.password) {
                  context.read<NavBloc>().add(EditPassConfirmEvent(tempPass));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) =>
                          const ShowAlertMessage(text: "Wrong Password"));
                }
              } else {
                showDialog(
                    context: context,
                    builder: (context) =>
                        const ShowAlertMessage(text: "Password didn't match"));
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) => const ShowAlertMessage(
                      text: "Please fill all fields to continue"));
            }
          } else if (state is ChangePassSucceed) {
            confirmNewPassController.clear();
            newPassController.clear();
            passwordController.clear();

            showDialog(
                context: context,
                builder: (context) => const ShowAlertMessage(
                      text: "Your password has been successfully updated",
                      hasSucceed: true,
                    ));
          } else if (state is ChangePassFailed) {
            final String errorMessage = state.message == "No Internet"
                ? "No Internet Connection"
                : "An error occurred while updating your password";
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
            appBar: AppBar(),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                SizedBox(
                  height: h * .05,
                  width: w,
                ),
                ChangePassForm(
                    passwordController: passwordController,
                    NewPassController: newPassController,
                    ConfirmNewPassController: confirmNewPassController),
                SizedBox(
                  height: h * .02,
                ),
                SizedBox(
                  width: horizontal ? w * .85 : h * .85,
                  child: state is ChangePasswordLoadingState
                      ? const CupertinoActivityIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            context.read<NavBloc>().add(EditPassEvent());
                          },
                          style: ButtonStyle(
                              elevation: const WidgetStatePropertyAll(8),
                              backgroundColor: WidgetStatePropertyAll(
                                  Colors.greenAccent.shade100)),
                          child: const Text(
                            "Submit",
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Madimi",
                            ),
                          ),
                        ),
                ),
              ],
            ),
          );
        });
  }
}
