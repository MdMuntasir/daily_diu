import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/home/presentation/widgets/customText.dart';
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


    Widget _information = Container(
      width: w,
      height: h*.48,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(spreadRadius: -10,blurRadius: 20,color: Colors.blue)],
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(w*.25),bottomRight: Radius.circular(w*.25)),
        ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: h*.05,),
            Text(
              "Welcome "+ _name,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h*.05,),
            CustomText(first: "ID", second: _id),
            SizedBox(height: h*.035,),
            CustomText(first: "Department", second: Information.departments[_dept][0]),
            SizedBox(height: h*.035,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(first: "Batch", second: _batch),
                SizedBox(width: w*.001,),
                CustomText(first: "Section", second: _sec),
                SizedBox(width: w*.001,)
              ],
            ),


          ],
        ),
      ),
    );


    return Scaffold(
      body: Column(
        children: [
          _information,
          SizedBox(height: h*.1,),
          SlotShower()
        ],
      ),
    );
  }
}
