import 'package:flutter/material.dart';

import '../../../../config/theme/custom themes/form_theme.dart';

class Toogler extends StatefulWidget {
  final VoidCallback func;
  final bool toggled;
  final double height;
  final double width;

  const Toogler({
    super.key,
    required this.func,
    required this.toggled,
    this.height = .05,
    this.width = .6,
  });

  @override
  State<Toogler> createState() => _TooglerState();
}

class _TooglerState extends State<Toogler> {
  Duration _duration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).extension<FormTheme>()!;

    double mainHeight = h * widget.height, mainWidth = w * widget.width;
    bool isToggled = widget.toggled;

    void _toggle() {
      widget.func();
      setState(() {});
    }

    return InkWell(
      onTap: _toggle,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: mainWidth,
        height: mainHeight,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: theme.sliderFgColor,
            boxShadow: const [
              BoxShadow(
                  blurRadius: 20,
                  spreadRadius: -15,
                  color: Colors.black87,
                  offset: Offset(1, 4))
            ]),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: _duration,
              right: isToggled ? 0 : mainWidth * .5,
              child: Container(
                height: mainHeight,
                width: mainWidth * .5,
                decoration: BoxDecoration(
                    color: theme.sliderBgColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
            ),
            Row(
              children: [
                _text("Student", mainWidth * .5, mainHeight, !isToggled, theme),
                _text("Teacher", mainWidth * .5, mainHeight, isToggled, theme),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer _text(text, width, height, val, FormTheme theme) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: height,
      width: width,
      child: Center(
          child: AnimatedDefaultTextStyle(
              duration: _duration,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: val ? theme.sliderFgColor : theme.sliderBgColor),
              child: Text(text))),
    );
  }
}
