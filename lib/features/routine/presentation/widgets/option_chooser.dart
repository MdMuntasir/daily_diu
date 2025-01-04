import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class OptionChooser extends StatefulWidget {
  final bool enable;
  final TextEditingController controller;
  final List list;
  final VoidCallback onChoose;
  const OptionChooser({super.key, required this.controller, required this.list, required this.onChoose, this.enable=true});

  @override
  State<OptionChooser> createState() => _OptionChooserState();
}

class _OptionChooserState extends State<OptionChooser> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    List list = widget.list;
    if(selected == "")
    {
      selected = list.isEmpty? "None" : list[0];
    }

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    h>w? w = w : w = h;

    List<PopupMenuItem> options = [];


    list.forEach((ele) {
      options.add(PopupMenuItem(
          value: ele,
          onTap: (){
            widget.controller.text = ele;
            widget.onChoose();
            setState(() {
              selected = ele;
            });
          },
          child: SizedBox(
              child: Center(
                child: Text(
                  ele,
                  style: TextStyle(color: Colors.teal.shade500, fontWeight: FontWeight.bold),
                ),
              ))
      ));
    });


    return SizedBox(
      width: w*.45,
      child: Builder(
        builder: (BuildContext context){
          return ElevatedButton(
              onPressed: widget.enable ? (){
                showPopover(
                    width: w*.4,
                    context: context,
                    bodyBuilder: (BuildContext context) => SingleChildScrollView(child: Column(children: options,)),
                    direction: PopoverDirection.bottom,
                    backgroundColor: Colors.teal.shade50
                );
              } : (){},
              style: ButtonStyle(
                  backgroundColor: widget.enable ? WidgetStatePropertyAll(Colors.white) : WidgetStatePropertyAll(Colors.grey),
                  foregroundColor: widget.enable ? WidgetStatePropertyAll(Colors.teal.shade500) : WidgetStatePropertyAll(Colors.white),
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
              ),
              child: Text(selected, style: TextStyle(fontSize: 18),)
          );
        },
      ),
    );
  }
}
