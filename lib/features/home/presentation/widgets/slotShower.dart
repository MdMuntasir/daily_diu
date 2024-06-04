import 'package:diu_student/core/resources/information_repository.dart';
import 'package:flutter/material.dart';

class SlotShower extends StatefulWidget {
  @override
  _SlotShowerState createState() => _SlotShowerState();
}

class _SlotShowerState extends State<SlotShower> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    List timeStamps = [];

    for (var time in test_time[0]["Time"]) {
      List splited = time.toString().split("-");

      List start = [int.parse(splited[0].split(":")[0]),splited[0].split(":")[1]],
          end = [int.parse(splited[1].split(":")[0]),splited[1].split(":")[1]];

      start[0] = start[0] < 7 ? start[0] + 12 : start[0];
      end[0] = end[0] < 7 ? end[0] + 12 : end[0];

      splited[0] = "${start[0]}:${start[1]}";
      splited[1] = "${end[0]}:${end[1]}";
      timeStamps.add((
      splited[0],
      splited[1]));
    }
    print(timeStamps);
    print(DateTime.now());



    return Container(
      width: w,
      height: h*.15,
      color: Colors.white,
      child: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            height: h*.05,
          )
        ],
      ),
    );
  }

}
