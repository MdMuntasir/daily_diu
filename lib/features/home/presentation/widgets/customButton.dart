import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? function;
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color fgColor;
  const CustomButton({super.key, required this.icon, required this.label, required this.bgColor, required this.fgColor, this.function});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    return InkWell(
      onTap: function,
      child: Hero(
        tag: label,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: w*.25,
            width: w*.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(w*.05)),
                color: bgColor,
                boxShadow: [BoxShadow(spreadRadius: -3,blurRadius: 5)]
              ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: w*.02),
              child: Column(
                spacing: h*.015,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: fgColor,size: w*.07,),
                  Text(label,
                    style: TextStyle(
                        color: fgColor,
                        fontSize: w*.043,
                        fontWeight: FontWeight.bold
                    ),)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
