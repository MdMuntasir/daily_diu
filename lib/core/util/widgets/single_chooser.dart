import 'package:diu_student/config/theme/custom%20themes/form_theme.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class SingleChooser extends StatefulWidget {
  final VoidCallback func;
  final TextEditingController controller;
  final Map map;
  final String title;

  const SingleChooser({
    super.key,
    required this.map,
    required this.controller,
    this.title = "None",
    required this.func,
  });

  @override
  State<SingleChooser> createState() => _SingleChooserState();
}

class _SingleChooserState extends State<SingleChooser> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).extension<FormTheme>()!;

    Map map = widget.map;
    if (selected == "") {
      selected = widget.title;
    }

    h > w ? w = w : w = h;

    List<PopupMenuItem> options = [];

    map.forEach((short, element) {
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
                  color: theme.deepColor, fontWeight: FontWeight.bold),
            ),
          ))));
    });

    return ElevatedButton(
        onPressed: () {
          showPopover(
              width: w * .8,
              context: context,
              bodyBuilder: (BuildContext context) => SingleChildScrollView(
                      child: Column(
                    children: options,
                  )),
              direction: PopoverDirection.bottom,
              backgroundColor: theme.lightColor);
        },
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(theme.chooserBgColor),
            foregroundColor: WidgetStatePropertyAll(theme.chooserFgColor),
            elevation: WidgetStatePropertyAll(1.5),
            shadowColor: WidgetStatePropertyAll(theme.deepColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))))),
        child: Text(
          selected,
          style: TextStyle(fontSize: 18),
        ));
  }
}
