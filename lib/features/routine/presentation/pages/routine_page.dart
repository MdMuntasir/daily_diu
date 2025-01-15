import 'package:diu_student/features/routine/presentation/pages/blank_routine.dart';
import 'package:diu_student/features/routine/presentation/pages/manual_routine.dart';
import 'package:diu_student/features/routine/presentation/pages/routineSearch_screen.dart';
import 'package:diu_student/features/routine/presentation/widgets/option_chooser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/constants&variables/variables.dart';
import '../../../../core/controller/boolean_controller.dart';
import 'package:diu_student/features/routine/presentation/widgets/department_chooser.dart';
import '../../../navbar/presentation/pages/NavBar.dart';

class MainRoutinePage extends StatefulWidget {
  const MainRoutinePage({super.key});

  @override
  State<MainRoutinePage> createState() => _MainRoutinePageState();
}

class _MainRoutinePageState extends State<MainRoutinePage> {
  BooleanController studentController = BooleanController();
  BooleanController teacherController = BooleanController();
  BooleanController emptyController = BooleanController();
  BooleanController manualController = BooleanController();

  TextEditingController optionController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    optionController.dispose();
    searchController.dispose();

    super.dispose();
  }

  bool deptSelected = false;

  List options = ["Student", "Teacher", "Empty Slot", "Manual Search"];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    Map<String, Widget> widgets = {
      "Student": RoutineSearchScreen(student: true, deptSelected: deptSelected),
      "Teacher":
          RoutineSearchScreen(student: false, deptSelected: deptSelected),
      "Empty Slot": EmptySlots(),
      "Manual Search": ManualRoutine()
    };

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Hero(
            tag: "Routine",
            child: Text(
              "Routine",
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * .05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => NavBar()));
                      },
                      color: Colors.teal.shade900,
                      icon: Icon(FontAwesomeIcons.barsStaggered)),
                ],
              ),
            )
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: h * .02,
          children: [
            SizedBox(
              width: w,
            ),

            //Buttons on the upper section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ChooseDepartment(
                  func: () {
                    studentController.setValue(hasFunction);
                    teacherController.setValue(hasFunction);
                    emptyController.setValue(hasFunction);
                    manualController.setValue(hasFunction);
                    setState(() {
                      deptSelected = true;
                    });
                  },
                ),
                OptionChooser(
                  enable: deptSelected,
                  list: options,
                  controller: optionController,
                  onChoose: () {
                    setState(() {});
                  },
                )
              ],
            ),

            widgets[optionController.text] ?? widgets["Student"]!
          ],
        ),
      ),
    );
  }
}
