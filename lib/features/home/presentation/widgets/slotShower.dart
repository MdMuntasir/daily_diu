import 'package:diu_student/core/resources/information_repository.dart';
import 'package:flutter/material.dart';

class SlotShower extends StatefulWidget {
  @override
  _SlotShowerState createState() => _SlotShowerState();
}

class _SlotShowerState extends State<SlotShower> {
  Duration _duration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double mainHeight = h*.25;
    double mainWidth = w*.85;
    double round = 20;

    return Container(
      width: mainWidth,
      height: mainHeight,
      color: Colors.transparent,
      child: Column(
        children: [
          AnimatedContainer(
            duration: _duration,
            height: mainHeight*.25,
            width: mainWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(round),
                topRight: Radius.circular(round)
              ),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -5 ,
                  blurRadius: 7,
                  offset: Offset(0, 1),
                  color: Colors.teal
                )
              ]
            ),

          ),
          Divider(height: mainHeight*.05,color: Colors.transparent,),
          AnimatedContainer(
            duration: _duration,
            height: mainHeight*.70,
            width: mainWidth,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(round),
                    bottomRight: Radius.circular(round)
                )
            ),
          ),
        ],
      ),
    );
  }

}
