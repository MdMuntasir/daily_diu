import 'package:diu_student/core/widgets/bottom_navbar.dart';
import 'package:diu_student/features/routine/data/repository/student/slot_repo_implement.dart';
import 'package:diu_student/features/routine/data/repository/time_repository_implement.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_bloc.dart';
import 'package:diu_student/features/routine/presentation/state/student%20routine/student_routine_state.dart';
import 'package:diu_student/features/routine/presentation/widgets/custom_textfield.dart';
import 'package:diu_student/features/routine/presentation/widgets/routine_shower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/repository/information_repository.dart';

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



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    if(!routineShowed) {
      space = h * .08;
      height1 = h*.5;
      width1 = w*.9;
      height2 = h*.1;
      width2 = w*.9;
    }



    void showRoutine() async{
      batchSection = batchController.text + sectionController.text;

      routineShowed = true;
      height1 = h*.3;
      height2 = h*.45;
      space = h*.02;
      setState(() {});
    }
    
    
    Column upperPart = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: w*.5,
          child: CustomTextField(
            controller: batchController,
            textHint: "Enter your batch",
            label: "Batch",
            maxLen: 2,
            isDigit: true,),
        ),
        SizedBox(
          width: w*.5,
          child: CustomTextField(
            controller: sectionController,
            textHint: "Enter your section",
            label: "Section",
            maxLen: 1,
            ),
        ),
        ElevatedButton(
            onPressed: showRoutine,
            child: Text("See Routine",style: TextStyle(fontWeight: FontWeight.bold),),
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Theme.of(context).primaryColor),
            foregroundColor: MaterialStatePropertyAll(Colors.white)
          ),
        )
      ],
    );


    var lowerPart = routineShowed ?
        FutureBuilder(
            future: getStudentRoutineRemotely(batchSection: batchSection).getRoutine(),
            builder: (context,slots){
              if(slots.connectionState == ConnectionState.done) {
                print(slots.data);
                return RoutineShower(times: Times, body: slots.data!);
              }
              else{
                return Center(child: CupertinoActivityIndicator());
              }
            })

        : SizedBox();







    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.blue.shade50,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Hero(
                tag: "Student", child: Text(
              "Student",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold
              ),
            )),
            SizedBox(height: space,width: w,),
            AnimatedContainer(
              height: height1,
              width: width1,
              duration: duration,
              decoration: BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(height1*.1)),
                  boxShadow: [BoxShadow(spreadRadius: -20,blurRadius: 30,color: Colors.lightBlueAccent)]
              ),
              child: upperPart,
            ),

            SizedBox(height: h*.03,width: w,),


            AnimatedContainer(
              height: height2,
              width: width2,
              duration: duration,
              decoration: routineShowed ? BoxDecoration(
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.all(Radius.circular(height2*.1)),
                  boxShadow: [BoxShadow(spreadRadius: -20,blurRadius: 30,color: Colors.lightBlueAccent)]
              ):
              BoxDecoration(color: Colors.transparent),
              child: lowerPart,
            ),
          ],
        ),

        bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
                iconTheme: const IconThemeData(color: Colors.white)
            ),
            child: BottomNavbar()),
      ),

    );

  }
  _routineBody(){
    return routineShowed ? BlocBuilder<StudentRoutineBloc, StudentRoutineState>(
        builder: (_,state){
          if(state is StudentRoutineLoading){
            return Center(child: CupertinoActivityIndicator());
          }
          if(state is StudentRoutineError){
            print(state.exception);
            return Center(child: Text("Something went wrong"));
          }
          if(state is StudentRoutineDone){
            return Center(child: Text("Done"),);
          }
          return const SizedBox();
        }
    ) : SizedBox();
  }
}
