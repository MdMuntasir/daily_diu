import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatefulWidget {
  final Duration duration;
  final bool controller;
  final Color color;
  final VoidCallback func;
  const AnimatedBar({
    super.key,
    required this.duration,
    required this.controller,
    required this.color,
    required this.func});

  @override
  State<AnimatedBar> createState() => _AnimatedBarState();
}

class _AnimatedBarState extends State<AnimatedBar> {

  double left = 0, right = 0, height = 0, width = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    void _func(){
      widget.func();
      setState(() {
      });
    }

    if(widget.controller){
      height = h*.008;
      width = w*.1;
      left = -0.03;
      right = 0.03;
    }
    else if (left != 0 && right != 0){
      height = h*.008;
      width = w*.15;
      left = 0;
      right = 0;
    }

    return InkWell(
      onTap: _func,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedRotation(
              duration: widget.duration,
              turns: left,
              child: AnimatedContainer(
                duration: widget.duration,
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(w*.1),
                    bottomLeft: Radius.circular(w*.1),
                  )
                ),
              )
          ),


          AnimatedRotation(
              duration: widget.duration,
              turns: right,
              child: AnimatedContainer(
                duration: widget.duration,
                height: height,
                width: width,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(w*.1),
                    bottomRight: Radius.circular(w*.1),
                  )
                ),
              )
          ),
        ],
      ),
    );
  }
}
