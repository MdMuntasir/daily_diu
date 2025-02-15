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
  static const List<String> days = [
    "Saturday",
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
  ];

  final weekdayToIndex = {
    1: 2,
    2: 3,
    3: 4,
    4: 5,
    5: 6,
    6: 0,
    7: 1,
  };

  late String choosed_day;
  late DateTime _dayTime;
  late final Map<String, List<SlotEntity>> _sortedSlots;
  late final Map<String, List<Widget>> _cachedSlotCards;

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _dayTime = DateTime.now();

    choosed_day = days[weekdayToIndex[_dayTime.weekday]!];

    _sortedSlots = _sortSlotsByDay();
    _cachedSlotCards = {};

    _timer = Timer.periodic(const Duration(minutes: 1), (_) {
      final now = DateTime.now();
      if (_dayTime.minute != now.minute) {
        setState(() => _dayTime = now);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Map<String, List<SlotEntity>> _sortSlotsByDay() {
    final Map<String, List<SlotEntity>> sorted = {};
    for (final day in days) {
      sorted[day] = widget.slots.where((slot) => slot.day == day).toList();
    }
    return sorted;
  }

  List<Widget> _buildSlotCards(String day) {
    // Return cached cards if available
    if (_cachedSlotCards.containsKey(day)) {
      return _cachedSlotCards[day]!;
    }

    final slots = _sortedSlots[day] ?? [];
    final List<Widget> cards = [];
    final double h = MediaQuery.of(context).size.height;
    final time = _dayTime.hour + _dayTime.minute / 60;

    for (final slot in slots) {
      final List<String> splited = slot.time!.toString().split("-");
      final timeRange = _parseTimeRange(splited);

      final bool classNow = time >= timeRange[0] &&
          time < timeRange[1] &&
          days[weekdayToIndex[_dayTime.weekday]!] == day;

      cards.add(SlotShower(
        slots: slot,
        isActive: classNow,
      ));
      cards.add(SizedBox(height: h * .03));
    }

    // Cache the cards
    _cachedSlotCards[day] = cards;
    return cards;
  }

  List<double> _parseTimeRange(List<String> timeRange) {
    List<double> result = [];
    for (String time in timeRange) {
      final parts = time.split(":");
      double hours = double.parse(parts[0]);
      hours = hours < 7 ? hours + 12 : hours;
      final minutes = double.parse(parts[1]);
      result.add(hours + minutes / 60);
    }
    return result;
  }

  Widget _buildDayButtons() {
    final Map<String, List<dynamic>> dayShort = {
      "Saturday": ["Sat", () => setState(() => choosed_day = "Saturday")],
      "Sunday": ["Sun", () => setState(() => choosed_day = "Sunday")],
      "Monday": ["Mon", () => setState(() => choosed_day = "Monday")],
      "Tuesday": ["Tue", () => setState(() => choosed_day = "Tuesday")],
      "Wednesday": ["Wed", () => setState(() => choosed_day = "Wednesday")],
      "Thursday": ["Thu", () => setState(() => choosed_day = "Thursday")],
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: days
          .where((day) => day != "Friday")
          .map((day) => DayButton(
                function: dayShort[day]![1],
                fullDay: day,
                shortDay: dayShort[day]![0],
                current: choosed_day == day,
              ))
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final bool horizontal = h > w;
    final double effectiveHeight = widget.height == 0 ? 45 : widget.height;
    final List<Widget> slotCards = _buildSlotCards(choosed_day);

    return Column(
      children: [
        SizedBox(
          height: horizontal ? h * .1 : w * .1,
          child: _buildDayButtons(),
        ),
        SizedBox(height: horizontal ? h * .01 : w * .01),
        SizedBox(
          height: h * .01 * effectiveHeight,
          child: slotCards.isEmpty
              ? _buildEmptyDayView(h)
              : SingleChildScrollView(
                  child: Column(children: slotCards),
                ),
        ),
      ],
    );
  }

  Widget _buildEmptyDayView(double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: h * .2,
          child: Image.asset("assets/images/Sleeping.png"),
        ),
        Text(
          days[weekdayToIndex[_dayTime.weekday]!] == choosed_day
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
    );
  }
}
