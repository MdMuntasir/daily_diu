import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/home/presentation/widgets/customText.dart';
import 'package:diu_student/features/home/presentation/widgets/informationShower.dart';
import 'package:diu_student/features/home/presentation/widgets/slotShower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String _name = "Muntasir Vai",
      _dept = "SWE",
      _batch = "41",
      _sec = "N",
      _id = "232-35-689",
      _ti = "SUP";




  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;




    List timeStamps = [];

    for (var time in test_time[0]["Time"]) {
      List splited = time.toString().split("-");

      List start = [int.parse(splited[0].split(":")[0]),int.parse(splited[0].split(":")[1])],
          end = [int.parse(splited[1].split(":")[0]),int.parse(splited[1].split(":")[1])];

      start[0] = start[0] < 7 ? start[0] + 12 : start[0];
      end[0] = end[0] < 7 ? end[0] + 12 : end[0];

      splited[0] = "${start[0] + start[1]/60}";
      splited[1] = "${end[0] + end[1]/60 - .01}";
      timeStamps.add((
      splited[0],
      splited[1]));
    }
    print(timeStamps);
    print(DateTime.now());



    Widget _information = InfoShow(Name: _name, ID: _id, Department: _dept, Batch: _batch, Section: _sec);





    return Scaffold(
      body: Column(
        children: [
          _information,
          SizedBox(height: h*.05,),
          SlotShower()
        ],
      ),
    );
  }
}
