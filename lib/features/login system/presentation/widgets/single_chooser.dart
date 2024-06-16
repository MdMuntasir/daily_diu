import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:popover/popover.dart';

class SingleChooser extends StatefulWidget {
  final VoidCallback func;
  final TextEditingController controller;
  final Map map;
  final String title;
  const SingleChooser({super.key, required this.map, required this.controller, this.title = "None", required this.func});

  @override
  State<SingleChooser> createState() => _SingleChooserState();
}

class _SingleChooserState extends State<SingleChooser> {

  String selected = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    Map map = widget.map;
    if(selected == "")
    {
      selected = widget.title;
    }


    h>w? w = w : w = h;

    List<PopupMenuItem> options = [];




    map.forEach((short,element) {
      String long = element.runtimeType == String ? element : short;

      options.add(PopupMenuItem(
          value: short,
          onTap: () {
            widget.controller.text = short;
            setState(() {
              selected = short;
            });
            widget.func();
          },
          child: SizedBox(
              child: Center(
                child: Text(
                  long,
                  style: TextStyle(
                      color: Colors.blue.shade500, fontWeight: FontWeight.bold),
                ),
              ))));
    });


    return ElevatedButton(
        onPressed: (){
          showPopover(
              width: w*.8,
              context: context,
              bodyBuilder: (BuildContext context) => SingleChildScrollView(child: Column(children: options,)),
              direction: PopoverDirection.bottom,
              backgroundColor: Colors.blue.shade50
          );
        },
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(Colors.blue.shade500),
            elevation: WidgetStatePropertyAll(1.5),
            shadowColor: WidgetStatePropertyAll(Colors.teal),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
        ),
        child: Text(selected, style: TextStyle(fontSize: 18),)
    );
  }
}
