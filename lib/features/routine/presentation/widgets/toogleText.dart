import 'package:diu_student/core/controller/boolean_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TextToggle extends StatefulWidget {
  final String text;
  final VoidCallback func;
  final bool toggled;
  const TextToggle({super.key, required this.func, required this.toggled, required this.text});

  @override
  State<TextToggle> createState() => _TextToggleState();
}

class _TextToggleState extends State<TextToggle> {


  Duration _duration = Duration(milliseconds: 200);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h>w;

    double mainHeight = horizontal ? h*.035 : w*.035,
        mainWidth = horizontal ? w*.2 : h*.2,
        fontSize = horizontal ? w*.045 : h*.05;
    bool isToggled = widget.toggled;


    void _toggle(){
      widget.func();
      setState(() {
      });

    }


    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            widget.text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade600
          ),
        ),

        SizedBox(width: w*.05,),

        InkWell(
          onTap: _toggle,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: mainWidth,
            height: mainHeight,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [BoxShadow(
                    blurRadius: 20,
                    spreadRadius: -15,
                    color: Colors.black87,
                    offset: Offset(1,4)
                )]
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: _duration,
                  right: isToggled? 0 : mainWidth*.5,
                  child: Container(
                    height: mainHeight,
                    width: mainWidth*.5,
                    decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                  ),
                ),
                Row(
                  children: [
                    _text("No", mainWidth*.5, mainHeight, !isToggled),
                    _text("Yes", mainWidth*.5, mainHeight, isToggled)
                  ]
                  ,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }




  AnimatedContainer _text(text, width, height, val){
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: height,
      width: width,
      child: Center(
          child: AnimatedDefaultTextStyle(
              duration: _duration,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: val? Colors.white : Colors.blue
              ),

              child: Text(text))
      ),
    );
  }
}
