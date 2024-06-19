import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAlertBox extends StatelessWidget {
  final String text;
  final VoidCallback function;
  const CustomAlertBox({super.key, this.text = "Are you sure?", required this.function});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Cancel" , style: TextStyle(color: Colors.black87, fontSize: 15),)),
        TextButton(
            onPressed: function,
            child: Text("Yes", style: TextStyle(color: Colors.black54, fontSize: 15))),
      ],
      content: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold
        ) , ),
    );
  }
}