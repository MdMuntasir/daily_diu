import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/features/navbar/presentation/widgets/change_pass.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  final TextEditingController confirmNewPassController = TextEditingController();
  User user = FirebaseAuth.instance.currentUser!;
  bool isLoading = false;



  @override
  void dispose()
  {
    passwordController.dispose();
    newPassController.dispose();
    confirmNewPassController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h>w;
    bool isStudent = studentInfo.user!=null;



    Future<void> _updatePass() async {
      String pass = passwordController.text;
      String newPass = newPassController.text;
      String confirmNewPass = confirmNewPassController.text;


      setState(() {
        isLoading = true;
      });


      if(pass.isNotEmpty && newPass.isNotEmpty && confirmNewPass.isNotEmpty) {


        if (newPassController.text == confirmNewPassController.text) {
          String tempPass = newPass;

          if(isStudent) {

            if(studentInfo.password == pass) {
              try {
                await user
                    .reauthenticateWithCredential(EmailAuthProvider.credential(
                        email: studentInfo.email!,
                        password: pass))
                    .then(
                  (value) async {


                    await user.updatePassword(tempPass).then((value) {
                      FirebaseFirestore.instance.collection("student").doc(studentInfo.docID!).update({
                        "password" : tempPass

                      }).then((value) async {

                        await getUserInfo();
                        showDialog(
                            context: context,
                            builder: (context) =>
                                const ShowAlertMessage(text: "Successfully updated password", hasSucceed: true,));
                      },);

                    },);
                  },
                );
              } on FirebaseAuthException catch (e) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ShowAlertMessage(text: e.code.toString()));
              }
            }

            else{
              showDialog(
                  context: context,
                  builder: (context) =>
                      ShowAlertMessage(text: "Wrong password"));
            }

          }

          else{

            if(teacherInfo.password == pass) {
              try {
                await user
                    .reauthenticateWithCredential(EmailAuthProvider.credential(
                    email: teacherInfo.email!,
                    password: pass))
                    .then(
                      (value) async {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                ShowAlertMessage(text: "Successfully updated password", hasSucceed: true,));

                        await user.updatePassword(tempPass).then((value) {

                          FirebaseFirestore.instance.collection("teacher").doc(teacherInfo.docID!).update({
                            "password" : tempPass
                          }).then((value) async {

                            await getUserInfo();
                            showDialog(
                                context: context,
                                builder: (context) =>
                                const ShowAlertMessage(text: "Successfully updated password", hasSucceed: true,));
                          },);

                        },);
                  },
                );
              } on FirebaseAuthException catch (e) {
                showDialog(
                    context: context,
                    builder: (context) =>
                        ShowAlertMessage(text: e.code.toString()));
              }
            }

            else{
              showDialog(
                  context: context,
                  builder: (context) =>
                      ShowAlertMessage(text: "Wrong password"));
            }

          }
        }

        else{
          showDialog(
              context: context,
              builder: (context) =>
                  ShowAlertMessage(text: "Password didn't match"));
        }
      }

      else{
        showDialog(
            context: context,
            builder: (context) =>
                ShowAlertMessage(text: "To continue all fields are required"));
      }

      setState(() {
        isLoading = false;
      });

    }



    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
          "Change Password",
          style: Theme.of(context).textTheme.displayLarge,),


          SizedBox(height: h*.1,),


          ChangePassForm(
              passwordController: passwordController,
              NewPassController: newPassController,
              ConfirmNewPassController: confirmNewPassController),


          SizedBox(height: h*.02,),


          SizedBox(
            width: horizontal ? w*.85: h*.85,
            child: isLoading?
            CupertinoActivityIndicator()
            :
            ElevatedButton(
              onPressed: _updatePass,

              style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(8),
                  backgroundColor: WidgetStatePropertyAll(Colors.greenAccent.shade100)),
              child: const Text(
                "Submit",
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
    );
  }
}
