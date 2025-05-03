import 'package:diu_student/config/theme/custom%20themes/routine_theme.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class CustomChooser extends StatefulWidget {
  final TextEditingController controller;
  final List list;
  final String label;

  const CustomChooser(
      {super.key,
      required this.list,
      required this.controller,
      required this.label});

  @override
  State<CustomChooser> createState() => _CustomChooserState();
}

class _CustomChooserState extends State<CustomChooser> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    List list = widget.list;
    if (selected == "") {
      selected = "None";
    }

    double w = MediaQuery.of(context).size.width;

    final theme = Theme.of(context).extension<RoutineTheme>()!;

    List<PopupMenuItem> options = [];

    options.add(PopupMenuItem(
        value: "None",
        onTap: () {
          widget.controller.text = "";
          setState(() {
            selected = "None";
          });
        },
        child: SizedBox(
            child: Center(
          child: Text(
            "None",
            style: TextStyle(color: theme.bgColor, fontWeight: FontWeight.bold),
          ),
        ))));

    list.forEach((value) {
      options.add(PopupMenuItem(
          value: value,
          onTap: () {
            widget.controller.text = value;
            setState(() {
              selected = value;
            });
          },
          child: SizedBox(
              child: Center(
            child: Text(
              value,
              style:
                  TextStyle(color: theme.bgColor, fontWeight: FontWeight.bold),
            ),
          ))));
    });

    return SizedBox(
      width: w * .7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.label + " : ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 16),
          ),
          Builder(
            builder: (BuildContext context) {
              return ElevatedButton(
                  onPressed: () {
                    showPopover(
                        width: w * .4,
                        context: context,
                        bodyBuilder: (BuildContext context) =>
                            SingleChildScrollView(
                                child: Column(
                              children: options,
                            )),
                        direction: PopoverDirection.top,
                        backgroundColor: theme.fgColor);
                  },
                  style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          theme.chooserColor.withAlpha(220)),
                      foregroundColor: WidgetStatePropertyAll(theme.bgColor),
                      shape: const WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))),
                  child: Text(
                    selected,
                    style: TextStyle(fontSize: 18),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
