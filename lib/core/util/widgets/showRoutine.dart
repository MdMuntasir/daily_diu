import 'dart:async';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/widgets/dayButton.dart';
import 'package:diu_student/core/util/widgets/slotShower.dart';
import 'package:flutter/material.dart';

class ShowRoutine extends StatefulWidget {
  final double height;
  final List<SlotEntity> slots;

  const ShowRoutine({super.key, required this.slots, this.height = 0});

  @override
  State<ShowRoutine> createState() => _ShowRoutineState();
}

class _ShowRoutineState extends State<ShowRoutine> {
  List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final List<String> sortedDays = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];
  String choosed_day = "Saturday";
  DateTime _dayTime = DateTime.now();
  int _toDay = DateTime.now().weekday - 1;
  int dayIndex = DateTime.now().weekday - 1;
  bool start = true;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 30), (_) {
      final now = DateTime.now();
      if (_dayTime.minute != now.minute) {
        setState(() {
          _dayTime = now;
          _toDay = now.weekday - 1;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _sat() => setState(() => choosed_day = 'Saturday');

  void _sun() => setState(() => choosed_day = 'Sunday');

  void _mon() => setState(() => choosed_day = 'Monday');

  void _tue() => setState(() => choosed_day = 'Tuesday');

  void _wed() => setState(() => choosed_day = 'Wednesday');

  void _thu() => setState(() => choosed_day = 'Thursday');

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double height = widget.height == 0 ? 45 : widget.height;
    bool horizontal = h > w;

    if (start) {
      choosed_day = days[_dayTime.weekday - 1];
      start = false;
    }

    // Filter slots for today
    List<SlotEntity> TodaySlots =
        widget.slots.where((slot) => slot.day == choosed_day).toList();

    // Build slot cards
    List<Widget> SlotCards = [];
    for (var slot in TodaySlots) {
      List splited = slot.time!.toString().split("-");
      List start = [
        int.parse(splited[0].split(":")[0]),
        int.parse(splited[0].split(":")[1])
      ];
      List end = [
        int.parse(splited[1].split(":")[0]),
        int.parse(splited[1].split(":")[1])
      ];

      start[0] = start[0] < 7 ? start[0] + 12 : start[0];
      end[0] = end[0] < 7 ? end[0] + 12 : end[0];

      double startTime = start[0] + start[1] / 60;
      double endTime = end[0] + end[1] / 60;
      double currentTime = _dayTime.hour + _dayTime.minute / 60;

      bool classNow = currentTime >= startTime &&
          currentTime < endTime &&
          days[_toDay] == choosed_day;

      SlotCards.add(SlotShower(
        slots: slot,
        isActive: classNow,
      ));
      SlotCards.add(SizedBox(height: h * .03));
    }

    // Build day buttons
    Map<String, List<dynamic>> day_short = {
      "Saturday": ["Sat", _sat],
      "Sunday": ["Sun", _sun],
      "Monday": ["Mon", _mon],
      "Tuesday": ["Tue", _tue],
      "Wednesday": ["Wed", _wed],
      "Thursday": ["Thu", _thu],
    };

    List<Widget> dayButtons = [];
    for (var day in sortedDays) {
      if (day != "Friday") {
        dayButtons.add(DayButton(
          function: day_short[day]![1],
          fullDay: day,
          shortDay: day_short[day]![0],
          current: choosed_day == day,
        ));
      }
    }

    return Column(
      children: [
        SizedBox(
          height: horizontal ? h * .1 : w * .1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: dayButtons,
          ),
        ),
        SizedBox(
          height: horizontal ? h * .01 : w * .01,
        ),
        SlotCards.isEmpty
            ? SizedBox(
                height: h * .01 * height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: h * .2,
                      child: Image.asset("assets/images/Sleeping.png"),
                    ),
                    Text(
                      days[_toDay] == choosed_day
                          ? "No class today\nEnjoy your day"
                          : "This is your off day",
                      style: const TextStyle(
                        fontFamily: "Madimi",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : SizedBox(
                height: h * .01 * height,
                child: SingleChildScrollView(
                  child: Column(
                    children: SlotCards,
                  ),
                ),
              ),
      ],
    );
  }
}
