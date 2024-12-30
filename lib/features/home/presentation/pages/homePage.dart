import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/home/presentation/widgets/bottomBar.dart';
import 'package:diu_student/features/navbar/presentation/pages/NavBar.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_routine.dart';
import 'package:diu_student/features/home/presentation/widgets/informationShower.dart';
import 'package:diu_student/features/home/presentation/widgets/showRoutine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants&variables/constants.dart';
import '../../../../core/util/services.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isNow = false, showOptions = false;
  final bool isStudent = studentInfo.user != "";
  bool isDownloading = false;

  double pos = 0, prog = 0;

  Radius left = Radius.zero,right = Radius.zero;
  Widget _information = SizedBox();

  Gradient lightGrad1 = LinearGradient(colors: [Color(0xFF74ebd5), Color(0xFFACB6E5),]);
  Color bottomColor = Color(0xFFB6EADA);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    if(!showOptions){
      pos = -h*.585;
      left = Radius.elliptical(w, h*.2);
      right = Radius.elliptical(w, h*.2);
    }
    else{
      pos = 0;
      left = Radius.circular(w*.2);
      right = Radius.circular(w*.2);
    }


    void barFunc(){
      showOptions = !showOptions;
      setState(() {
      });
    }




    Future<void> _downloadRoutine() async{

      bool RequestAccepted;

      final _checkConnection = await Connectivity().checkConnectivity();
      bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);

      if(android_info.version.sdkInt <= 32){
        RequestAccepted = await Permission.storage.request().isGranted;
      }
      else{
        RequestAccepted = await Permission.photos.request().isGranted;
      }


      String info = isStudent? "${studentInfo.batch!}${studentInfo.section!}" : "${teacherInfo.ti}";


      if(RequestAccepted){
        if(isConnected){
          setState(() {
            isDownloading = true;
          });

          await Services().DownloadFile(

              url: isStudent? "$routine_api/${studentInfo.department}/routine-pdf/$info" :
              "$routine_api/${teacherInfo.department}/full-teacher-pdf/$info",

              filename: info,

              (path) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(path)));
              },

              onDownloadError: (){
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Download failed")));
              }
          );


          setState(() {
            isDownloading = false;
          });
        }

        else{
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No Internet Connection")));
        }
      }
    }





    List timeStamps = [];

    for (var time in test_time[0]["Time"]) {
      List splited = time.toString().split("-");

      List start = [int.parse(splited[0].split(":")[0]),int.parse(splited[0].split(":")[1])],
          end = [int.parse(splited[1].split(":")[0]),int.parse(splited[1].split(":")[1])];

      start[0] = start[0] < 7 ? start[0] + 12 : start[0];
      end[0] = end[0] < 7 ? end[0] + 12 : end[0];

      splited[0] = "${start[0] + start[1]/60}";
      splited[1] = "${end[0] + end[1]/60 - .01}";
      timeStamps.add((
      splited[0],
      splited[1]));
    }


    if(studentInfo.user != null){
      String name = studentInfo.name.toString().split(" ")[0];
      _information = StudentInfoShow(
          Name: name,
          ID: studentInfo.id!,
          Department: studentInfo.department!,
          Batch: studentInfo.batch!,
          Section: studentInfo.section!,
          grad: lightGrad1,
      );
    }


    else {
      String dept = teacherInfo.department.toString().split('-').join("+");
      String name = teacherInfo.name.toString().split(" ")[0];

      _information = TeacherInfoShow(
        Name: name,
        Department: dept,
        Faculty: teacherInfo.faculty!,
        TeacherInitial: teacherInfo.ti!,
        grad: lightGrad1,
      );
    }

    // print(MainRoutine);

    return GestureDetector(
      onVerticalDragDown: (details){
        if(details.globalPosition.dy <= h*.42)
          showOptions = false;
        else if(details.globalPosition.dy >= h*.934 && details.globalPosition.dy <= h)
          showOptions = true;
        setState(() {
        });
      },



      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: h*.05,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NavBar()));
                    },
                    color: Colors.black87,
                    icon: Icon(FontAwesomeIcons.barsStaggered)),

                isDownloading?
                    CircularProgressIndicator()
                :
                IconButton(
                    onPressed: _downloadRoutine,
                    icon: Icon(FontAwesomeIcons.download, size: 18,)
                )
              ],
            ),
          ),
        ),
        backgroundColor: Colors.teal.shade100,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              width: w,
              height: h,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _information,

                    ShowRoutine(slots: MainRoutine,)
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              bottom: pos,
              duration: Duration(milliseconds: 500),
              child: BottomPanel(
                  color: bottomColor,
                  controller: !showOptions,
                  left: left,
                  right: right,
                  function: barFunc),
            )
          ],
        ),
      ),
    );
  }
}
