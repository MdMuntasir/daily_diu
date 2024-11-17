import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/controller/boolean_controller.dart';

class HeroCard extends StatefulWidget {
  final BooleanController controller;
  final VoidCallback function;
  final String tag;
  final String text;
  final IconData icon;

  const HeroCard({
    super.key,
    required this.controller,
    required this.function,
    required this.tag,
    required this.text,
    required this.icon
  });

  @override
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard> {
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
          child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: w*.4,
              width: w*.4,
              decoration: BoxDecoration(
                  color: enabled ? Colors.blue.shade500 : Colors.blueGrey,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: enabled ? [
                    BoxShadow(blurRadius: 2, offset: Offset(1,1), color: Colors.blue.withOpacity(.5)),
                    BoxShadow(blurRadius: 20, spreadRadius: -10, color: Colors.blue)
                  ] : []
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w*.05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon, color: Colors.white,size: 45,),
                      SizedBox(height: w*.25*.25,),
                      Flexible(
                        fit: FlexFit.loose,
                        child: Text(
                          widget.text,
                          style: const TextStyle(
                              fontSize: 20,
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
