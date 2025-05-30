import 'package:diu_student/config/theme/custom%20themes/routine_theme.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/routine/presentation/widgets/custom_chooser.dart';
import 'package:diu_student/features/routine/presentation/widgets/manual_slots_shower.dart';
import 'package:diu_student/features/routine/presentation/widgets/manual_text_field.dart';
import 'package:flutter/material.dart';

class ManualRoutine extends StatefulWidget {
  final List<SlotEntity> allSlots;
  final List times;

  const ManualRoutine({super.key, required this.allSlots, required this.times});

  @override
  State<ManualRoutine> createState() => _ManualRoutineState();
}

class _ManualRoutineState extends State<ManualRoutine> {
  double height2 = 0, width2 = 0;
  bool routineShowed = false;
  final List days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday"
  ];

  TextEditingController dayController = TextEditingController();
  TextEditingController roomController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController teacherController = TextEditingController();
  TextEditingController batchController = TextEditingController();
  TextEditingController sectionController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void dispose() {
    dayController.dispose();
    roomController.dispose();
    courseController.dispose();
    teacherController.dispose();
    batchController.dispose();
    sectionController.dispose();
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).extension<RoutineTheme>()!;

    double width1 = w * .9;

    if (!routineShowed) {
      height2 = h * .05;
      width2 = w * .9;
    }

    void ShowSlots() {
      routineShowed = true;
      height2 = 350;
      setState(() {});
    }

    Column upperPart = Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: h * .005,
        ),
        SizedBox(
          width: w * .5,
        ),
        CustomChooser(list: days, controller: dayController, label: "Day"),
        CustomChooser(
          list: widget.times,
          controller: timeController,
          label: "Time",
        ),
        ManualTextField(controller: roomController, title: "Room"),
        ManualTextField(
            controller: teacherController, title: "Teacher Initial"),
        ManualTextField(
            controller: batchController, title: "Batch", isDigit: true),
        ManualTextField(controller: sectionController, title: "Section"),
        ManualTextField(controller: courseController, title: "Course Code"),
        SizedBox(
          height: h * .005,
        ),
        ElevatedButton(
          onPressed: ShowSlots,
          child: const Text(
            "Search",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: h * .005,
        ),
      ],
    );

    ManualSlotShower showSlots = ManualSlotShower(
      Slots: widget.allSlots,
      Batch: batchController.text.toUpperCase(),
      CourseCode: courseController.text.toUpperCase(),
      Day: dayController.text,
      Room: roomController.text,
      Section: sectionController.text.toUpperCase(),
      TeacherInitial: teacherController.text.toUpperCase(),
      Time: timeController.text,
    );

    Widget lowerPart = routineShowed ? showSlots : SizedBox();

    return SizedBox(
      height: h * .75,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 450,
              width: width1,
              decoration: BoxDecoration(
                  color: theme.fgColor,
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: -20,
                        blurRadius: 30,
                        color: theme.deepColor)
                  ]),
              child: upperPart,
            ),
            SizedBox(
              height: h * .03,
              width: w,
            ),
            AnimatedContainer(
              height: height2,
              width: width2,
              duration: Duration(milliseconds: 300),
              decoration: routineShowed
                  ? BoxDecoration(
                      color: theme.fgColor,
                      borderRadius:
                          BorderRadius.all(Radius.circular(height2 * .1)),
                      boxShadow: [
                          BoxShadow(
                              spreadRadius: -20,
                              blurRadius: 30,
                              color: theme.deepColor)
                        ])
                  : BoxDecoration(color: Colors.transparent),
              child: lowerPart,
            ),
          ],
        ),
      ),
    );
  }
}
