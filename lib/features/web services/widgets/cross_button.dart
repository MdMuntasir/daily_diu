import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/presentation/pages/homePage.dart';

class CrossButton extends StatelessWidget {
  final double crossButtonSize;
  final Color color;
  const CrossButton({super.key, required this.crossButtonSize, required this.color,});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: crossButtonSize,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
          ),
        ),

        Positioned(
          left: -crossButtonSize*.15,
          child: IconButton(
              onPressed: (){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>homePage()));},
              icon: Icon(Icons.close,size: crossButtonSize*.75 ,color: color,)),
        )
      ],
    );
  }
}
