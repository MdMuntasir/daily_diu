import 'package:diu_student/core/controller/boolean_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroButton extends StatefulWidget {
  final BooleanController controller;
  final VoidCallback function;
  final String tag;
  final String text;
  final IconData icon;

  const HeroButton({
    super.key,
    required this.controller,
    required this.function,
    required this.tag,
    required this.icon,
    this.text = "button",
  });

  @override
  State<HeroButton> createState() => _HeroButtonState();
}

class _HeroButtonState extends State<HeroButton> {
  @override
  Widget build(BuildContext context) {
    bool enabled = widget.controller.value;
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Hero(
      tag: widget.tag,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? widget.function : (){},
          child: Container(
            height: h*.08,
            width: w*.7,
            decoration: BoxDecoration(
              color: enabled ? Colors.blueAccent.shade200 : Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: enabled ? [
                BoxShadow(blurRadius: 2, offset: Offset(1,1), color: Colors.black87),
                BoxShadow(blurRadius: 25, spreadRadius: -10, color: Colors.blueAccent)
              ] : []
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w*.05),
                child: Row(
              children: [
                Icon(widget.icon, color: Colors.white,size: 22,),
                SizedBox(width: w*.08,),
                Flexible(
                  fit: FlexFit.loose,
                  child: Text(
                    widget.text,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Colors.white
                    ),
                  ),
                ),
              ],
            )
            )
          ),
        ),
      ),
    );
  }
}
