import 'package:diu_student/config/theme/custom%20themes/routine_theme.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:flutter/material.dart';

class ManualSlotShower extends StatefulWidget {
  final List<SlotEntity> Slots;
  final String Day;
  final String Time;
  final String Room;
  final String TeacherInitial;
  final String Batch;
  final String Section;
  final String CourseCode;

  const ManualSlotShower(
      {super.key,
      this.Slots = const [],
      this.Day = "",
      this.Time = "",
      this.Room = "",
      this.TeacherInitial = "",
      this.Batch = "",
      this.Section = "",
      this.CourseCode = ""});

  @override
  State<ManualSlotShower> createState() => _ManualSlotShowerState();
}

class _ManualSlotShowerState extends State<ManualSlotShower> {
  List<SlotEntity> Slots = [];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).extension<RoutineTheme>()!;

    Text boldText(text) {
      return Text(
        text,
        style: TextStyle(color: theme.deepColor, fontWeight: FontWeight.bold),
      );
    }

    Text normalText(text) {
      return Text(
        text,
        style: TextStyle(color: theme.bgColor, fontWeight: FontWeight.bold),
      );
    }

    Container SlotCard(List<Widget> lst) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: w * .1, vertical: h * .02),
        padding: EdgeInsets.symmetric(horizontal: w * .15, vertical: h * .01),
        decoration: BoxDecoration(
            color: theme.fgColor,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(blurRadius: 25, spreadRadius: -10, color: theme.bgColor)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: lst,
        ),
      );
    }

    List filteredSlots = [];

    widget.Slots.forEach((slot) {
      String sec = slot.section != "" ? slot.section![0] : "";
      bool matched = true;
      List<Text> texts = [];
      if (widget.Batch != "" && widget.Batch != slot.batch) {
        matched = false;
      }
      if (widget.Day != "" && widget.Day != slot.day) {
        matched = false;
      }
      if (widget.Time != "" && widget.Time != slot.time) {
        matched = false;
      }
      if (widget.CourseCode != "" && widget.CourseCode != slot.course) {
        matched = false;
      }
      if (widget.TeacherInitial != "" && widget.TeacherInitial != slot.ti) {
        matched = false;
      }
      if (widget.Room != "" && widget.Room != slot.room) {
        matched = false;
      }
      if (widget.Section != "" && widget.Section != sec) {
        matched = false;
      }

      if (matched == true) {
        widget.Day != "" && widget.Day == slot.day
            ? texts.add(boldText("Day : " + widget.Day))
            : texts.add(normalText("Day : " + slot.day!));

        widget.Time != "" && widget.Time == slot.time
            ? texts.add(boldText("Time : " + widget.Time))
            : texts.add(normalText("Time : " + slot.time!));

        widget.CourseCode != "" && widget.CourseCode == slot.course
            ? texts.add(boldText("Course Code : " + widget.CourseCode))
            : texts.add(normalText("Course Code : " + slot.course!));

        widget.Room != "" && widget.Room == slot.room
            ? texts.add(boldText("Room : " + widget.Room))
            : texts.add(normalText("Room : " + slot.room!));

        widget.TeacherInitial != "" && widget.TeacherInitial == slot.ti
            ? texts.add(boldText("Teacher Initial : " + widget.TeacherInitial))
            : texts.add(normalText("Teacher Initial : " + slot.ti!));

        widget.Batch != "" && widget.Batch == slot.batch
            ? texts.add(boldText("Batch : " + widget.Batch))
            : texts.add(normalText("Batch : " + slot.batch!));

        widget.Section != "" && widget.Section == sec
            ? texts.add(boldText("Section : " + slot.section!))
            : texts.add(normalText("Section : " + slot.section!));

        filteredSlots.add(SlotCard(texts));
      }
    });

    return ListView.builder(
      itemCount: filteredSlots.length,
      itemBuilder: (BuildContext context, int index) {
        return filteredSlots[index];
      },
    );
  }
}
