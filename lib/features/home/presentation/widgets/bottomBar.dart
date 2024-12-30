import 'package:diu_student/features/home/presentation/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'animatedBar.dart';

class BottomPanel extends StatefulWidget {
  final VoidCallback function;
  final Color IconbgColor;
  final Color IconfgColor;
  final Color color;
  final bool controller;
  final Radius left;
  final Radius right;
  const BottomPanel({
    super.key,
    required this.controller,
    required this.left,
    required this.right,
    required this.function,
    this.color = const Color(0xFFB6EADA),
    this.IconbgColor = const Color(0xFF58BCAD),
    this.IconfgColor = const Color(0xFFB6EADA)});

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {


  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    CustomButton btn1 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.calendarDays,
      function: (){

      },
      label: "Routine",
    );
    CustomButton btn2 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.graduationCap,
      label: "Portal",
    );
    CustomButton btn3 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.chalkboardUser,
      label: "BLC",
    );
    CustomButton btn4 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.bell,
      label: "Notice",
    );
    CustomButton btn5 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.info,
      label: "Info",
    );
    CustomButton btn6 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.chartLine,
      label: "Result",
    );
    CustomButton btn7 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.leanpub,
      label: "Notes",
    );
    CustomButton btn8 = CustomButton(
      bgColor: widget.IconbgColor,
      fgColor: widget.IconfgColor,
      icon: FontAwesomeIcons.calendarCheck,
      label: "Events",
    );

    void _func(){
      widget.function();
      setState(() {
      });
    }


    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: h*.65,
      width: w,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 50,spreadRadius: -48)],
        color: widget.color,
        borderRadius: BorderRadius.only(
          topLeft: widget.left,
          topRight: widget.right,
        ),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: h*.03,),

          AnimatedBar(
              duration: Duration(milliseconds: 300),
              controller: widget.controller,
              color: Colors.white,
              func: _func),

          SizedBox(height: h*.05,),
          
          SizedBox(
            height: h*.52,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w*.1),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Wrap(
                  spacing: w*.2,
                  runSpacing: w*.15,
                  children: [btn1,btn2,btn3,btn4,btn5,btn6,btn7,btn8],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
