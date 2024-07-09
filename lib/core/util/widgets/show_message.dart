import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowAlertMessage extends StatelessWidget {
  final bool hasSucceed;
  final String text;
  const ShowAlertMessage({super.key, required this.text, this.hasSucceed = false, });

  @override
  Widget build(BuildContext context) {


    return AlertDialog(

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hasSucceed ?  Text("Succeed!") : Text("Alert!"),
          IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(FontAwesomeIcons.xmark))
        ],
      ),

      content: Text(
        text,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400
        ) , ),
    );
  }
}