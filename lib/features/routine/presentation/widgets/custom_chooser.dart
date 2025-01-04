import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popover/popover.dart';

class CustomChooser extends StatefulWidget {
  final TextEditingController controller;
  final List list;
  final String label;
  const CustomChooser({super.key, required this.list, required this.controller, required this.label});

  @override
  State<CustomChooser> createState() => _CustomChooserState();
}

class _CustomChooserState extends State<CustomChooser> {

  String selected = "";

  @override
  Widget build(BuildContext context) {
    List list = widget.list;
    if(selected == "")
      {
        selected = "None" ?? "";
      }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    h>w? w = w : w = h;

    List<PopupMenuItem> options = [];

    options.add(PopupMenuItem(
        value: "None",
        onTap: (){
          widget.controller.text = "";
          setState(() {
            selected = "None";
          });
        },
        child: SizedBox(
            child: Center(
              child: Text(
                "None",
                style: TextStyle(color: Colors.teal.shade500, fontWeight: FontWeight.bold),
              ),
            ))
    ));


    list.forEach((time) {
      options.add(PopupMenuItem(
          value: time,
          onTap: (){
            widget.controller.text = time;
            setState(() {
              selected = time;
            });
          },
          child: SizedBox(
              child: Center(
                child: Text(
                    time,
                  style: TextStyle(color: Colors.teal.shade500, fontWeight: FontWeight.bold),
                ),
              ))
          ));
    });


    return SizedBox(
      width: w*.7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:
        [
          Text(
              widget.label + " : ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 16
            ),
          ),

          Builder(
            builder: (BuildContext context){
            return ElevatedButton(
                onPressed: (){
                  showPopover(
                      width: w*.4,
                      context: context,
                      bodyBuilder: (BuildContext context) => SingleChildScrollView(child: Column(children: options,)),
                      direction: PopoverDirection.top,
                    backgroundColor: Colors.teal.shade50
                  );
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                    foregroundColor: WidgetStatePropertyAll(Colors.teal.shade500),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
                ),
                child: Text(selected, style: TextStyle(fontSize: 18),)
            );
            },
          ),
        ],
      ),
    );
  }
}
