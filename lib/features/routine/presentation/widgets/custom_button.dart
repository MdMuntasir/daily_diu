import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroButton extends StatelessWidget {
  final VoidCallback function;
  final String tag;
  final String text;
  final IconData icon;
  const HeroButton({
    super.key,
    required this.function,
    required this.tag,
    required this.icon,
    this.text = "button",
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Hero(
      tag: tag,
      child: InkWell(

        onTap: function,
        child: Container(
          height: h*.08,
          width: w*.7,
          decoration: BoxDecoration(
            color: Colors.blueAccent.shade200,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(blurRadius: 2, offset: Offset(1,1), color: Colors.black87),
              BoxShadow(blurRadius: 25, spreadRadius: -10, color: Colors.blueAccent)
            ]
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: w*.05),
              child: Row(
            children: [
              Icon(icon, color: Colors.white,),
              SizedBox(width: w*.08,),
              Text(
                text,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.white
                ),
              ),
            ],
          ))
        ),
      ),
    );
  }
}
