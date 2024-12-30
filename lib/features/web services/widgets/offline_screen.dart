import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfflineScreen extends StatelessWidget {
  final VoidCallback function;
  const OfflineScreen({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off, size: 120, color: Colors.red.shade300,),


        SizedBox(height: h*.02,),

        Text(
          "No Internet Connection!",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: "Madimi",
              color: Colors.red.shade300
          ),
        ),

        SizedBox(height: h*.05,width: w,),


        TextButton(
          onPressed: function,
          child: SizedBox(
            width: w*.5,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.arrowsRotate,size: 15,),
                SizedBox(width: 8,),
                Text(
                  "Refresh",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Madimi"
                  ),
                ),
              ],

            ),
          ),
        ),
      ],
    );
  }
}
