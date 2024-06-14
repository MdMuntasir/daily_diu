import 'dart:async';
import 'dart:math';


import 'package:diu_student/features/home/presentation/widgets/dayButton.dart';
import 'package:diu_student/features/home/presentation/widgets/slotShower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/information_repository.dart';
import '../../data/models/slot.dart';


class ShowRoutine extends StatefulWidget {
  final List<SlotModel> slots;// change model later
  const ShowRoutine({super.key, required this.slots});

  @override
  State<ShowRoutine> createState() => _ShowRoutineState();
}

class _ShowRoutineState extends State<ShowRoutine> {
  List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday" ,"Saturday", "Sunday"];
  String choosed_day = "Saturday";
  DateTime _dayTime = DateTime.now();
  int _toDay = DateTime.now().weekday-1;
  int dayIndex = DateTime.now().weekday-1;
  bool start = true;


  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 10), (_){
      if(_dayTime.minute != DateTime.now().minute){
        _dayTime = DateTime.now();
        setState(() {});
      }
    });

  }


  void _sat(){
    choosed_day = 'Saturday';
    setState(() {
    });
  }

  void _sun(){
    choosed_day = 'Sunday';
    setState(() {
    });
  }

  void _mon(){
    choosed_day = 'Monday';
    setState(() {
    });
  }


  void _tue(){
    choosed_day = 'Tuesday';
    setState(() {
    });
  }


  void _wed(){
    choosed_day = 'Wednesday';
    setState(() {
    });
  }


  void _thu(){
    choosed_day = 'Thursday';
    setState(() {
    });
  }



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    bool horizontal = h>w;

    if(start) {
      choosed_day = choosed_day != days[_dayTime.weekday-1]
          ? days[_dayTime.weekday-1]
          : choosed_day;
      start = false;
    }

    List<SlotModel> TodaySlots = [];

    widget.slots.forEach((slot){
      if(slot.day == choosed_day){
        TodaySlots.add(slot);
      }
    });



    // Show routine slots of a day
    List<Widget> SlotCards = [];

    TodaySlots.forEach((slot){
      List splited = slot.time!.toString().split("-");

      List start = [int.parse(splited[0].split(":")[0]),int.parse(splited[0].split(":")[1])],
          end = [int.parse(splited[1].split(":")[0]),int.parse(splited[1].split(":")[1])];

      start[0] = start[0] < 7 ? start[0] + 12 : start[0];
      end[0] = end[0] < 7 ? end[0] + 12 : end[0];

      splited[0] = "${start[0] + start[1]/60}";
      splited[1] = "${end[0] + end[1]/60}";

      double time = _dayTime.hour + _dayTime.minute/60;
      bool classNow = time >= double.parse(splited[0]) && time < double.parse(splited[1]);


      SlotCards.add(SlotShower(slots: slot, isActive: classNow && days[_toDay] == choosed_day,));
      SlotCards.add(SizedBox(height: h*.03,));

    });



    //Buttons to shift days
    List<Widget> dayButtons = [];

    Map day_short = {
      "Saturday" : ["Sat", _sat],
      "Sunday" : ["Sun", _sun],
      "Monday" : ["Mon", _mon],
      "Tuesday" : ["Tue", _tue],
      "Wednesday" : ["Wed", _wed],
      "Thursday" : ["Thu", _thu],
    };


    Days.forEach(((day){
      if(day != "Friday") {
        dayButtons.add(DayButton(
            function: day_short[day][1],
            fullDay: day,
            shortDay: day_short[day][0],
            current: choosed_day == day,
        ));
      }
    }));


    return Container(

      child: Column(
        children: [
          SizedBox(
            height: horizontal? h*.1 : w*.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: dayButtons,
            ),
          ),

          SizedBox(height: horizontal? h*.01 : w*.01,),

          SlotCards.isEmpty ?
              SizedBox(
                height: h*.5,
                child: Center(child: Text(
                  days[_toDay] == choosed_day?
                  "No class today\nEnjoy your day" :
                  "This is your off day",
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    shadows: [Shadow(
                      blurRadius: 5,
                      offset: Offset(1, 1.5)
                    )]
                  ),
                  textAlign: TextAlign.center,
                ),),
              )
              :
          SizedBox(
            height: h*.5,
            child: SingleChildScrollView(
              child: Column(
                children: SlotCards,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
