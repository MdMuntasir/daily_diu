import 'package:diu_student/features/routine/domain/repository/information_repository.dart';
import 'package:diu_student/features/routine/presentation/widgets/custom_chooser.dart';
import 'package:diu_student/features/routine/presentation/widgets/manual_slots_shower.dart';
import 'package:diu_student/features/routine/presentation/widgets/manual_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_textfield.dart';

class ManualRoutine extends StatefulWidget {
  const ManualRoutine({super.key});

  @override
  State<ManualRoutine> createState() => _ManualRoutineState();
}

class _ManualRoutineState extends State<ManualRoutine> {
  double height2 = 0, width2 = 0;
  double space = 0;
  bool routineShowed = false;
  Color ShadowColor = Colors.lightBlueAccent, BodyColor = Colors.lightBlue.shade50;
  TextEditingController dayController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double height1 = h*.5;
    double width1 = w*.9;

    if(!routineShowed) {
      space = h * .08;
      height2 = h*.05;
      width2 = w*.9;
    }



    void ShowSlots(){
      routineShowed = true;
      height2 = h*.5;
      setState(() {
      });
    }


    Column upperPart = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: h*.005,),
        SizedBox(
          width: w*.5,
        ),

        CustomChooser(list: Days, controller: dayController, label: "Day"),
        CustomChooser(list: Times, controller: timeController, label: "Time",),
        ManualTextField(controller: roomController, title: "Room"),
        ManualTextField(controller: teacherController, title: "Teacher Initial"),
        ManualTextField(controller: batchController, title: "Batch", isDigit: true),
        ManualTextField(controller: sectionController, title: "Section"),
        ManualTextField(controller: courseController, title: "Course Code"),


        SizedBox(height: h*.005,),
        ElevatedButton(
          onPressed: ShowSlots,
          child: Text("Search",style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        SizedBox(height: h*.005,),
      ],
    );



    ManualSlotShower showSlots = ManualSlotShower(
      Batch: batchController.text.toUpperCase(),
      CourseCode: courseController.text.toUpperCase(),
      Day: dayController.text,
      Room: roomController.text.toUpperCase(),
      Section: sectionController.text.toUpperCase(),
      TeacherInitial: teacherController.text.toUpperCase(),
      Time: timeController.text,
    );



    Widget lowerPart = routineShowed ?
        showSlots
        : SizedBox();






    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h*.03,width: w,),
              Hero(
                  tag: "Manual", child: Text(
                "Manual Search",
                style: Theme.of(context).textTheme.displayLarge,
              )),
              SizedBox(height: h*.03,width: w,),

              Container(
                height: height1,
                width: width1,
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
                duration: Duration(milliseconds: 300),
                decoration: routineShowed ? BoxDecoration(
                    color: BodyColor,
                    borderRadius: BorderRadius.all(Radius.circular(height2*.1)),
                    boxShadow: [BoxShadow(spreadRadius: -20,blurRadius: 30,color: ShadowColor)]
                ):
                BoxDecoration(color: Colors.transparent),
                child: lowerPart,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
