import 'package:diu_student/config/theme/custom%20themes/routine_theme.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/empty_slot.dart';

class EmptySlotShow extends StatefulWidget {
  final List times;
  final List<EmptySlotEntity> slots;

  const EmptySlotShow({super.key, required this.times, required this.slots});

  @override
  State<EmptySlotShow> createState() => _EmptySlotShowState();
}

class _EmptySlotShowState extends State<EmptySlotShow> {
  String choosed_day = "Sat";
  double button_height = 0, button_width = 0;
  double selected_width = 0;
  double cell_width = 0;

  void _sat() {
    choosed_day = 'Sat';
    setState(() {});
  }

  void _sun() {
    choosed_day = 'Sun';
    setState(() {});
  }

  void _mon() {
    choosed_day = 'Mon';
    setState(() {});
  }

  void _tue() {
    choosed_day = 'Tue';
    setState(() {});
  }

  void _wed() {
    choosed_day = 'Wed';
    setState(() {});
  }

  void _thu() {
    choosed_day = 'Thu';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double cellHeight = h * .06,
        cellWidth = w * .2,
        headingWidth = w * .3,
        vSpace = h * .02,
        hSpace = w * .01;
    final theme = Theme.of(context).extension<RoutineTheme>()!;

    Container cellContainer(String text) {
      return Container(
        height: cellHeight,
        width: cellWidth,
        decoration: BoxDecoration(
            color: theme.lightColor, border: Border.all(color: theme.fgColor)),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: theme.deepColor, fontWeight: FontWeight.bold),
        )),
      );
    }

    Container headingContainer(String text) {
      return Container(
        height: cellHeight,
        width: headingWidth,
        decoration: BoxDecoration(
            color: theme.bgColor,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5), bottomRight: Radius.circular(15)),
            border:
                Border.symmetric(vertical: BorderSide(color: theme.fgColor))),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: theme.fgColor, fontWeight: FontWeight.bold),
        )),
      );
    }

    if (button_height == 0 && button_width == 0 && selected_width == 0) {
      button_height = h * .05;
      button_width = w * .1;
      selected_width = w * .3;
    }

    Map dayShort = {
      "Saturday": ["Sat", _sat],
      "Sunday": ["Sun", _sun],
      "Monday": ["Mon", _mon],
      "Tuesday": ["Tue", _tue],
      "Wednesday": ["Wed", _wed],
      "Thursday": ["Thu", _thu],
    };

    Map<String, List> SlotsOfDay = {};
    widget.times.forEach((time) {
      SlotsOfDay[time] = [];
    });

    widget.slots.forEach((slot) {
      if (dayShort[slot.day][0] == choosed_day) {
        SlotsOfDay[slot.time]?.add(slot.room);
      }
    });

    List<Widget> buttons = [];
    dayShort.forEach((key, value) {
      bool current = value[0] == choosed_day;
      buttons.add(InkWell(
        onTap: value[1],
        child: AnimatedContainer(
          width: current ? selected_width : button_width,
          height: button_height,
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
              color: current ? theme.bgColor : theme.deepColor,
              borderRadius:
                  BorderRadius.all(Radius.circular(h > w ? w * .05 : h * .05))),
          child: Center(
              child: Text(
            current ? value[0] : value[0][0],
            style: TextStyle(color: theme.fgColor, fontWeight: FontWeight.bold),
          )),
        ),
      ));
    });

    List<Widget> rows = [];
    SlotsOfDay.forEach((key, value) {
      List<Widget> cells = [];

      value.forEach((element) {
        cells.add(cellContainer(element));
      });

      rows.add(Row(
        children: [
          headingContainer(key),
          SizedBox(
            width: hSpace,
          ),
          Container(
            width: w - hSpace - headingWidth,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: cells,
              ),
            ),
          )
        ],
      ));

      if (key != SlotsOfDay.keys.last) {
        rows.add(SizedBox(
          height: vSpace,
        ));
      }
    });

    return SingleChildScrollView(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: buttons,
        ),
        SizedBox(
          height: h * .05,
        ),
        Column(
          children: rows,
        ),
        SizedBox(
          height: h * .05,
        )
      ],
    ));
  }
}
