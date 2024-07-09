import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:diu_student/core/constants&variables/constants.dart';
import 'package:diu_student/core/util/widgets/show_message.dart';
import 'package:diu_student/features/login%20system/presentation/widgets/multi_chooser.dart';
import 'package:diu_student/features/routine/presentation/widgets/custom_textfield.dart';
import 'package:diu_student/features/routine/presentation/widgets/routine_shower.dart';
import 'package:diu_student/features/routine/presentation/widgets/toogleText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/resources/information_repository.dart';
import '../../data/models/slot.dart';
import 'package:http/http.dart' as http;

class TeacherRoutine extends StatefulWidget {
  const TeacherRoutine({super.key});

  @override
  State<TeacherRoutine> createState() => _TeacherRoutineState();
}

class _TeacherRoutineState extends State<TeacherRoutine> {
  TextEditingController tiController = TextEditingController();
  TextEditingController deptController = TextEditingController();

  double height1 = 0, width1 = 0;
  double height2 = 0, width2 = 0;
  double space = 0;
  bool routineShowed = false;
  bool multiDepartment = false;

  Duration duration = Duration(milliseconds: 300);

  String teacherInitial = "";
  double? _progress;

  Color ShadowColor = Colors.lightBlueAccent, BodyColor = Colors.lightBlue.shade50;

  List<SlotModel> slots = [];
  Map Departments = {};
  List time = Times;



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // print(slots);
    if(!routineShowed) {
      if(h>w) {
        space = h * .1;
        height1 = h * .4;
        width1 = w * .9;
        height2 = h * .05;
        width2 = w * .9;
      }
      else{
        space = h * .1;
        height1 = w * .4;
        width1 = h * .9;
        height2 = h * .05;
        width2 = w * .9;
      }
    }


    if(Departments.isEmpty){
      Information.departments.forEach((key,val){
        Departments[key] = val[0];
      });
    }


    Future<void> downloadRoutine() async {
      teacherInitial = tiController.text.trim();
      String dept = deptController.text;
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
              url: !multiDepartment? "$routine_api/$selectedDepartment/teacher-pdf/$teacherInitial" :
              "$routine_api/$dept/full-teacher-pdf/$teacherInitial",
              name: teacherInitial + ".pdf",
              downloadDestination: DownloadDestinations.publicDownloads,
              onProgress: (fileName, progress) {
                setState(() {
                  _progress = progress;
                });
              },
              onDownloadError: (errorMessage) {
                print(errorMessage);
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("Download Failed")));
              },
              onDownloadCompleted: (path) {
                _progress = null;
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Downloaded at $path")));
              },
            );

        }

        else{
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("No Internet Connection")));
        }
      }
    }


    Future<void> showRoutine() async {
      routineShowed = true;
      height1 = h > w ? h * .3 : w * .3;
      height2 = h > w ? h * .45 : h * .8;
      space = h > w ? h * .02 : w * .02;



      if(multiDepartment){
        final dept = deptController.text;
        final ti = tiController.text.trim();
       if(dept.isNotEmpty){
         final _checkConnection = await Connectivity().checkConnectivity();
         bool isConnected = _checkConnection.contains(ConnectivityResult.mobile) || _checkConnection.contains(ConnectivityResult.wifi);

         if(isConnected){
           try{
             final uri = Uri.parse(routine_api+"/${dept}/full-teacher-routine?teacherInitial=${ti}");
             var response = await http.get(uri);

             if(response.statusCode == 200){
               List<dynamic> json = jsonDecode(response.body);
               slots.clear();
               json.forEach((slot){
                 slots.add(SlotModel.fromJson(slot));
               });

             }
           }

           on Exception catch(e){
             ScaffoldMessenger.of(context)
                 .showSnackBar(SnackBar(content: Text(e.toString())));
           }
         }

         else{
           ScaffoldMessenger.of(context)
               .showSnackBar(const SnackBar(content: Text("No Internet Connection")));
         }
       }

       else{
         ShowAlertMessage(text: "Select Department");
       }
      }

      else{
        teacherInitial = tiController.text.toUpperCase();
      }


      setState(() {});
    }




    if(!multiDepartment)
    {
      slots.clear();
      allSlots.forEach((slot) {
        if (slot.ti == teacherInitial) {
          slots.add(slot);
        }
      });
    }




    Column upperPart = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h*.005,),
        SizedBox(
          width: h>w ? w*.5 : h*.5,
          child: CustomTextField(
            controller: tiController,
            textHint: "Enter Teacher Initial",
            label: "Teacher Initial",
            maxLen: 4,
          ),
        ),

        ElevatedButton(
          onPressed: showRoutine,
          child: Text("See Routine",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: h*.005,)
      ],
    );



    // FutureBuilder _showRoutineRemotely = FutureBuilder(
    //     future: getTeacherRoutineRemotely(ti: teacherInitial).getRoutine(),
    //     builder: (context,slots){
    //       if(slots.connectionState == ConnectionState.done) {
    //         return RoutineShower(times: Times, body: slots.data!);
    //       }
    //       else{
    //         return Center(child: CupertinoActivityIndicator());
    //       }
    //     });


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
                  tag: "Teacher", child: Text(
                "Teacher",
                style: Theme.of(context).textTheme.displayLarge,
              )),

              SizedBox(height: space/2,width: w,),

              TextToggle(func: (){
                setState(() {
                  multiDepartment = !multiDepartment;
                });
              },
                toggled: multiDepartment,
                text: "Select multiple department?",
              ),


              multiDepartment?
              MultiChooser(controller: deptController, map: Departments, title: "Department",)
                  :
              SizedBox(),


              SizedBox(height: space/2,width: w,),

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