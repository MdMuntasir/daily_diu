import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/resources/information_repository.dart';
import 'customText.dart';

class InfoShow extends StatelessWidget {
  final String Name;
  final String ID;
  final String Department;
  final String Batch;
  final String Section;
  const InfoShow({super.key, required this.Name, required this.ID, required this.Department, required this.Batch, required this.Section});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;



    return Container(
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
              "Welcome "+ Name,
              style: Theme.of(context).textTheme.displayLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h*.05,),
            CustomText(first: "ID", second: ID),
            SizedBox(height: h*.035,),
            CustomText(first: "Department", second: Information.departments[Department][0]),
            SizedBox(height: h*.035,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(first: "Batch", second: Batch),
                SizedBox(width: w*.001,),
                CustomText(first: "Section", second: Section),
                SizedBox(width: w*.001,)
              ],
            ),


          ],
        ),
      ),
    );
  }
}
