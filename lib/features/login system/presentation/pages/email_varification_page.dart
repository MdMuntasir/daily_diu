import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/login%20system/presentation/pages/signup_page.dart';
import 'package:diu_student/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../home/data/data_sources/local/local_routine.dart';
import '../../../home/data/data_sources/local/local_user_info.dart';
import '../../../home/data/models/user_info.dart';
import '../../../home/data/repository/user_info_store.dart';

class EmailVerifyScreen extends StatefulWidget {
  final bool isStudent;
  final String docId;

  EmailVerifyScreen({
    super.key,
    required this.isStudent, required this.docId});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool Initialized = false;


  @override
  void initState() {
    Timer _timer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if(!Initialized){
        widget.isStudent ?
        await FirebaseFirestore.instance.collection("student").doc(widget.docId).update({
          'docID' : widget.docId
        }) :
        await FirebaseFirestore.instance.collection("teacher").doc(widget.docId).update({
          'docID' : widget.docId
        });
      }


      _auth.currentUser?.reload();
      if(_auth.currentUser!.emailVerified){
        timer.cancel();

        FirebaseFirestore _db = FirebaseFirestore.instance;
        User _user = _auth.currentUser!;


        widget.isStudent ?
        await FirebaseFirestore.instance.collection("student").doc(widget.docId).update({
          'verified' : true
        }).then((value) async {
          final snapshot = await _db.collection("student").where("email", isEqualTo: _user.email).get();
          StudentInfoModel userData = snapshot.docs.map((e) => StudentInfoModel.fromSnapshot(e)).single;

          await getRoutineLocally(userData.department,"${userData.batch}${userData.section}", true).then((_){
            StoreUserInfo(userData, true);
            getUserInfo();


            ScaffoldMessenger.of(context).showSnackBar(
                snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
                SnackBar(content: Text("Successfully Signed Up")));


            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
          }
          );

        },)

            :

        await FirebaseFirestore.instance.collection("teacher").doc(widget.docId).update({
          'verified' : true
        }).then((value) async {
          final snapshot = await _db.collection("teacher").where("email", isEqualTo: _user.email).get();
          TeacherInfoModel userData = snapshot.docs.map((e) => TeacherInfoModel.fromSnapshot(e)).single;

          await getRoutineLocally(userData.department,userData.ti, false).then((_){
            StoreUserInfo(userData, false);
            getUserInfo();


            ScaffoldMessenger.of(context).showSnackBar(
                snackBarAnimationStyle: AnimationStyle(duration: Duration(seconds: 2)),
                SnackBar(content: Text("Successfully Signed Up")));


            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          });
        });

      }
    });
    super.initState();
  }





  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;




    void _resendMail() async{
      await _auth.currentUser?.sendEmailVerification().then((value) {
        showDialog(context: context, builder: (context)=> ShowAlertMessage(text: "Email has been Sent"));
      },);
    }

    void _goBack() async{
      widget.isStudent ?

      await _auth.currentUser?.delete().then((value) async {
        await FirebaseFirestore.instance.collection("student").doc(widget.docId).delete().then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => SignupPage())
        ),);
      },)
          :
      await _auth.currentUser?.delete().then((value) async {
        await FirebaseFirestore.instance.collection("teacher").doc(widget.docId).delete().then((value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignupPage())
        ),);
      },);

    }


    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: w*.1),
        height: h,
        width: w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(FontAwesomeIcons.envelope,size: 120,color: Colors.red.shade300,),
            SizedBox( height: h*.05,),
            const Text(
                "Verify Email",
              style: TextStyle(
                fontSize: 38,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox( height: h*.02,),
            const Text(
                "A verification email has been sent to your email address. Please follow the link attached with the mail to verify your email.",
              style: TextStyle(
                fontSize: 18,
                fontFamily: "Times New Roman",
                fontWeight: FontWeight.w400
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox( height: h*.02,),
            TextButton(
                onPressed: _resendMail,
                child: SizedBox(
                  width: w*.5,
                  height: h*.04,
                  child: const ListTile(
                    leading: Icon(Icons.refresh,color: Colors.green,),
                    title: Text("Resend mail",style: TextStyle(color: Colors.green),),
                  ),
                )
            ),
            TextButton(
                onPressed: _goBack,
                child: SizedBox(
                  width: w*.5,
                  height: h*.05,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.arrow_back,color: Colors.blue,),
                      title: Text("Signup Page",style: TextStyle(color: Colors.blue),),
                    ),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
