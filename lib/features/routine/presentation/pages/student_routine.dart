import 'dart:async';
import 'dart:math';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/core/constants&variables/variables.dart';
import 'package:diu_student/features/routine/data/repository/student/slot_repo_implement.dart';
import 'package:diu_student/features/routine/presentation/widgets/custom_textfield.dart';
import 'package:diu_student/features/routine/presentation/widgets/routine_shower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../config/theme/Themes.dart';
import '../../../../core/resources/information_repository.dart';
import '../../data/models/slot.dart';

class StudentRoutine extends StatefulWidget {
  const StudentRoutine({super.key});

  @override
  State<StudentRoutine> createState() => _StudentRoutineState();
}

class _StudentRoutineState extends State<StudentRoutine> {
  double height1 = 0, width1 = 0;
  double height2 = 0, width2 = 0;
  double space = 0;
  bool routineShowed = false;

  Duration duration = Duration(milliseconds: 300);

  TextEditingController batchController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  String batchSection = "";
  double? _progress;

  Color ShadowColor = Colors.lightBlueAccent, BodyColor = Colors.lightBlue.shade50;







  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    if(!routineShowed) {
      space = h * .08;

      if(h>w) {
        height1 = h * .5;
        width1 = w * .9;
        height2 = h * .05;
        width2 = w * .9;
      }
      else{

        height1 = w * .5;
        width1 = h * .9;
        height2 = h * .05;
        width2 = w * .9;
      }
    }



    Future<void> downloadRoutine() async {
      bool RequestAccepted;
      final _checkConnection = await Connectivity().checkConnectivity();
      bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);

      if(android_info.version.sdkInt <= 32){
        RequestAccepted = await Permission.storage.request().isGranted;
      }
      else{
        RequestAccepted = await Permission.photos.request().isGranted;
      }
      if(RequestAccepted)
      {
        if(isConnected) {
          FileDownloader.downloadFile(
            url: "$routine_api/$selectedDepartment/routine-pdf/$batchSection",
            name: batchSection + ".pdf",
            downloadDestination: DownloadDestinations.publicDownloads,
            onProgress: (fileName, progress) {
              setState(() {
                _progress = progress;
              });
            },
            onDownloadError: (errorMessage) => print(errorMessage),
            onDownloadCompleted: (path) {
              _progress = null;
              print(path);
              setState(() {});
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Downloaded at $path")));
            },
          );
        }

        else{
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No Internet Connection")));
        }
      }
    }


    void showRoutine() {

      batchSection = batchController.text + sectionController.text.toUpperCase();
      BatchSection = batchSection;
      routineShowed = true;
      height1 = h>w? h*.3 : w*.3;
      height2 = h>w? h*.45 : h*.8;
      space = h>w? h*.02 : w*.02;
      setState(() {});
    }


    List<SlotModel> slots = [];
    allSlots.forEach((slot){
      if("${slot.batch}${slot.section![0]}" == batchSection){
        slots.add(slot);
      }

    });





    Widget upperPart = SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: routineShowed? h*.02 : h*.05,),

          SizedBox(
            width: h>w ? w*.5 : h*.5,
            child: CustomTextField(
              controller: batchController,
              textHint: "Enter your batch",
              label: "Batch",
              maxLen: 2,
              isDigit: true,),
          ),

          SizedBox(height: routineShowed? h*.01 : h*.05,),


          SizedBox(
            width: h>w ? w*.5 : h*.5,
            child: CustomTextField(
              controller: sectionController,
              textHint: "Enter your section",
              label: "Section",
              maxLen: 1,
            ),
          ),


          SizedBox(height: routineShowed? h*.01 : h*.05,),


          ElevatedButton(
            onPressed: showRoutine,
            child: Text("See Routine",style: TextStyle(fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );




    // FutureBuilder _showRoutineRemotely =  FutureBuilder(
    //       future: getStudentRoutineRemotely(batchSection: batchSection).getRoutine(),
    //       builder: (context,Slots){
    //         if(Slots.connectionState == ConnectionState.done) {
    //
    //           return RoutineShower(times: Times, body: Slots.data!);
    //         }
    //         else{
    //           return Center(child: CupertinoActivityIndicator());
    //         }
    //       });





    Widget lowerPart = routineShowed ?
    RoutineShower(times: Times, body: slots)
        : SizedBox();







    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: h*.1,width: w,),

              Hero(
                  tag: "Student", child: Text(
                "Student",
                style: Theme.of(context).textTheme.displayLarge,
              )),
              SizedBox(height: space,width: w,),
              AnimatedContainer(
                height: height1,
                width: width1,
                duration: duration,
                decoration: BoxDecoration(
                    color: BodyColor,
                    borderRadius: BorderRadius.all(Radius.circular(height1*.1)),
                    boxShadow: [BoxShadow(spreadRadius: -20,blurRadius: 30,color: ShadowColor)]
                ),
                child: upperPart,
              ),

              SizedBox(height: h*.03,width: w,),


              AnimatedContainer(
                height: height2,
                width: width2,
                duration: duration,
                decoration: routineShowed ? BoxDecoration(
                    color: BodyColor,
                    borderRadius: BorderRadius.all(Radius.circular(height2*.1)),
                    boxShadow: [BoxShadow(spreadRadius: -20,blurRadius: 30,color: ShadowColor)]
                ):
                BoxDecoration(color: Colors.transparent),
                child: lowerPart,
              ),

              SizedBox(height: h*.03,width: w,),

              routineShowed ?
              _progress == null ? ElevatedButton(
                onPressed: downloadRoutine,
                child: Text("Download Routine", style: TextStyle(fontWeight: FontWeight.bold),),
              ) : CircularProgressIndicator()
                  : SizedBox(),



              SizedBox(height: h*.05,width: w,),
            ],
          ),
        ),


      ),

    );

  }

}