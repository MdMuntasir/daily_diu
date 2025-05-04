import 'package:diu_student/config/theme/custom%20themes/routine_theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:popover/popover.dart';

class OptionChooser extends StatefulWidget {
  final bool enable;
  final TextEditingController controller;
  final List list;
  final VoidCallback onChoose;

  const OptionChooser({super.key,
    required this.controller,
    required this.list,
    required this.onChoose,
    this.enable = true});

  @override
  State<OptionChooser> createState() => _OptionChooserState();
}

class _OptionChooserState extends State<OptionChooser> {
  String selected = "";

  @override
  Widget build(BuildContext context) {
    List list = widget.list;
    if (selected == "") {
      selected = list.isEmpty ? "None" : list[0];
    }

    double w = MediaQuery
        .of(context)
        .size
        .width;

    final theme = Theme.of(context).extension<RoutineTheme>()!;

    List<PopupMenuItem> options = [];

    list.forEach((ele) {
      options.add(PopupMenuItem(
          value: ele,
          onTap: () {
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
                  style:
                  TextStyle(color: theme.bgColor, fontWeight: FontWeight.bold),
                ),
              ))));
    });

    return SizedBox(
      width: w * .45,
      child: Builder(
        builder: (BuildContext context) {
          return ElevatedButton(
              onPressed: widget.enable
                  ? () {
                showPopover(
                    width: w * .4,
                    context: context,
                    bodyBuilder: (BuildContext context) =>
                        SingleChildScrollView(
                            child: Column(
                              children: options,
                            )),
                    direction: PopoverDirection.bottom,
                    backgroundColor: theme.fgColor);
              }
                  : () {},
              style: ButtonStyle(
                  elevation: const WidgetStatePropertyAll(2),
                  backgroundColor: widget.enable
                      ? WidgetStatePropertyAll(theme.fgColor.withAlpha(220))
                      : WidgetStatePropertyAll(theme.inactiveBgColor),
                  foregroundColor: widget.enable
                      ? WidgetStatePropertyAll(theme.deepColor)
                      : WidgetStatePropertyAll(theme.inactiveFgColor),
                  shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  Text(
                    selected,
                    style: const TextStyle(fontSize: 17),
                  ),
                  Icon(
                    FontAwesomeIcons.caretDown,
                    color:
                    widget.enable ? theme.deepColor : theme.inactiveFgColor,
                  )
                ],
              ));
        },
      ),
    );
  }
}
