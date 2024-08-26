import 'package:diu_student/core/controller/boolean_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ToggleIcon extends StatefulWidget {
  final VoidCallback func;
  final bool toggled;
  final double height;
  final double width;
  final IconData icon1;
  final IconData icon2;
  const ToggleIcon({
    super.key,
    required this.func,
    required this.toggled,
    this.height = .04,
    this.width = .2,
    this.icon1 = FontAwesomeIcons.tableCells,
    this.icon2 = FontAwesomeIcons.bars,
  });

  @override
  State<ToggleIcon> createState() => _ToggleIconState();
}

class _ToggleIconState extends State<ToggleIcon> {


  Duration _duration = Duration(milliseconds: 200);
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    double mainHeight = h * widget.height, mainWidth = w * widget.width;
    bool isToggled = widget.toggled;


    void _toggle(){
      widget.func();
      setState(() {
      });

    }


    return InkWell(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: mainWidth,
        height: mainHeight,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
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
                _icon(widget.icon1, mainWidth*.5, mainHeight, !isToggled),
                _icon(widget.icon2, mainWidth*.5, mainHeight, isToggled)
              ]
              ,
            ),
          ],
        ),
      ),
    );
  }




  AnimatedContainer _icon(icon, width, height, val){

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: height,
      width: width,
      child: Center(
          child: Icon(
            icon,
            size: 16,
            color: val ? Colors.white : Colors.blue
          )
      ),
    );
  }
}
