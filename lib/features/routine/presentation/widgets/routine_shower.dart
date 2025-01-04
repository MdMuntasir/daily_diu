
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/model/slot.dart';

class RoutineShower extends StatelessWidget {
  final List times;
  final List<SlotModel> body;
  const RoutineShower({super.key, required this.times, required this.body});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    double cellHeight = 70, cellWidth = 100, border = 2;


    Color headColor = Colors.blue.shade500;
    Color baseColor = Colors.lightBlue.shade100;
    BorderRadius radius = BorderRadius.all(Radius.circular(5));
    List<OverlayPortalController> controllers = [];
    int controller_index = 0;


    Map day_short = {
      "Saturday" : "Sat",
      "Sunday" : "Sun",
      "Monday" : "Mon",
      "Tuesday" : "Tue",
      "Wednesday" : "Wed",
      "Thursday" : "Thu",
    };

    Map<String, List<List>> routineMap = {
      "Sat" : [],
      "Sun" : [],
      "Mon" : [],
      "Tue" : [],
      "Wed" : [],
      "Thu" : []
    };


    List<Widget> rows = [];

    body.forEach((value) {
          routineMap[day_short[value.day]]?.
          add(["${value.course}${value.section}" ,value.ti,value.room, value.time]);
        });

    List<Widget> dummy = [
      Container(
      height: cellHeight,
      width: cellWidth,
      decoration: BoxDecoration(
          color: headColor,
          borderRadius: radius
      ),
      ),
      SizedBox(width: border,)
    ];
    times.forEach((t) {
      dummy.add(
          Container(
            height: cellHeight,
            width: cellWidth,
            decoration: BoxDecoration(
              color: headColor,
              borderRadius: radius
            ),
            child: Center(child: Text(t, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
          ),
      );
      dummy.add(
        SizedBox(width: border,)
      );

    });
    rows.add(Row(children: dummy,));
    rows.add(SizedBox(height: border,));


    controllers.clear();





    routineMap.forEach((key, value) {

      if(value.isNotEmpty){
        dummy = [];
        dummy.add(
            Container(
              height: cellHeight,
              width: cellWidth,
              decoration: BoxDecoration(
                  color: headColor,
                  borderRadius: radius
              ),
              child: Center(child: Text(key, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
            )
        );
        dummy.add(SizedBox(width: border,));


        int counter = 0;
        times.forEach((t) {
          List temp = [];


          while(t == value[counter][3]){
            temp.add(value[counter]);

            if(counter+1 < value.length){counter++;}
            else{break;}
          }


          if(temp.length == 1){

            dummy.add(Container(
              height: cellHeight,
              width: cellWidth,
              decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: radius
              ),
              child: Center(child: Text(
                "${temp[0][0]}\n${temp[0][1]}\n${temp[0][2]}",
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),),
            ));


          }


          else if(temp.length>1){
            controllers.add(OverlayPortalController());

            String overText = "", mainText = "";
            temp.forEach((t){
              overText += "${t[0]}\n${t[1]}\n${t[2]}\n";
              mainText += "${t[0]}\n${t[2]}\n";
            });
            overText.trim();
            mainText.trim();

            dummy.add(
                Container(
                      height: cellHeight,
                      width: cellWidth,
                      decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: radius
                      ),
                      child: Center(
                          child: Text(
                              mainText,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: cellHeight*.18,
                                  color: Colors.black87),
                            textAlign: TextAlign.center,
                          )
                      ),
                            )
            );

            controller_index++;
          }

          else{
            dummy.add(Container(
              height: cellHeight,
              width: cellWidth,
              decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: radius
              ),
              child: Center(child: Text("---",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black87))),
            ));

          }

          if(t!=times.last) {
            dummy.add(SizedBox(
              width: border,
            ));
          }
        });

        rows.add(Row(children: dummy,));

        if(key != body.last) {
          rows.add(SizedBox(
            height: border,
          ));
        }
    }});



    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(children: rows,),
      ),
    );
  }
}
