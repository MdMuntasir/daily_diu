import 'package:diu_student/features/routine/data/models/slot.dart';
import 'package:diu_student/features/routine/data/repository/time_repository_implement.dart';
import 'package:diu_student/features/routine/domain/entities/slot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoutineShower extends StatelessWidget {
  final List times;
  final List<SlotModel> body;
  const RoutineShower({super.key, required this.times, required this.body});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double cellHeight = 70, cellWidth = 100, border = 2;


    Color headColor = Colors.blue.shade500;
    Color baseColor = Colors.lightBlue.shade100;


    Map day_short = {
      "Saturday" : "Sat",
      "Sunday" : "Sun",
      "Monday" : "Mon",
      "Tuesday" : "Tue",
      "Wednesday" : "Wed",
      "Thursday" : "Thu",
    };

    Map<String, List<List>> routineMap = {
      "Sat" : [],
      "Sun" : [],
      "Mon" : [],
      "Tue" : [],
      "Wed" : [],
      "Thu" : []
    };


    List<Widget> rows = [];

    body.forEach((value) {
          routineMap[day_short[value.day]]?.
          add([value.course,value.ti,value.room, value.time]);
        });

    List<Widget> dummy = [
      Container(
      height: cellHeight,
      width: cellWidth,
      color: headColor,),
      SizedBox(width: border,)
    ];
    times.forEach((t) {
      dummy.add(
          Container(
            height: cellHeight,
            width: cellWidth,
            color: headColor,
            child: Center(child: Text(t, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
          ),
      );
      dummy.add(
        SizedBox(width: border,)
      );

    });
    rows.add(Row(children: dummy,));
    rows.add(SizedBox(height: border,));



    routineMap.forEach((key, value) {
      if(value.isNotEmpty){
        dummy = [];
        dummy.add(
            Container(
              height: cellHeight,
              width: cellWidth,
              color: headColor,
              child: Center(child: Text(key, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
            )
        );
        dummy.add(SizedBox(width: border,));



        int counter = 0;
        times.forEach((t) {
          if(t == value[counter][3]){
            dummy.add(Container(
              height: cellHeight,
              width: cellWidth,
              color: baseColor,
              child: Center(child: Text(
                "${value[counter][0]}\n${value[counter][1]}\n${value[counter][2]}",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),),
            ));

            if(counter+1 < value.length){counter++;}
          }

          else{
            dummy.add(Container(
              height: cellHeight,
              width: cellWidth,
              color: baseColor,
              child: Center(child: Text("---",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87))),
            ));

          }

          if(t!=times.last) {
            dummy.add(SizedBox(
              width: border,
            ));
          }
        });

        rows.add(Row(children: dummy,));

        if(key != body.last) {
          rows.add(SizedBox(
            height: border,
          ));
        }
    }});


    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(children: rows,),
      ),
    );
  }
}
