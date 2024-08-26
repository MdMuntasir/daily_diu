import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/navbar/presentation/pages/NavBar.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_routine.dart';
import 'package:diu_student/features/home/data/models/slot.dart';
import 'package:diu_student/features/home/data/repository/routine_repo_implement.dart';
import 'package:diu_student/features/home/presentation/widgets/customText.dart';
import 'package:diu_student/features/home/presentation/widgets/informationShower.dart';
import 'package:diu_student/features/home/presentation/widgets/showRoutine.dart';
import 'package:diu_student/features/home/presentation/widgets/slotShower.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../../core/constants&variables/constants.dart';
import '../../../../core/util/services.dart';


class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool isNow = false;
  final bool isStudent = studentInfo.user != "";
  bool isDownloading = false;

  Widget _information = SizedBox();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;





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
          Section: studentInfo.section!);
    }


    else {
      String dept = teacherInfo.department.toString().split('-').join("+");
      String name = teacherInfo.name.toString().split(" ")[0];

      _information = TeacherInfoShow(
        Name: name,
        Department: dept,
        Faculty: teacherInfo.faculty!,
        TeacherInitial: teacherInfo.ti!,
      );
    }

    // print(MainRoutine);

    return Scaffold(

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
                    PersistentNavBarNavigator.pushNewScreen(
                        context,
                        withNavBar: false,
                        screen: NavBar());
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
      body: SizedBox(
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
    );
  }
}
