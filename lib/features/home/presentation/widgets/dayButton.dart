import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayButton extends StatefulWidget {
  final VoidCallback function;
  final bool current;
  final String fullDay;
  final String shortDay;
  const DayButton({super.key, required this.function, this.current = false, required this.fullDay, required this.shortDay});

  @override
  State<DayButton> createState() => _DayButtonState();
}

class _DayButtonState extends State<DayButton> {
  double button_height = 0, button_width = 0;
  double selected_width = 0;
  double cell_width = 0;



  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    if(button_height==0 && button_width == 0 && selected_width == 0){
      button_height = h*.05;
      button_width = w*.1;
      selected_width = w*.26;
    }

    return InkWell(
      onTap: widget.function,
      child: AnimatedContainer(
        width: widget.current ? selected_width : button_width,
        height: button_height,
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(

            gradient: widget.current?
            const LinearGradient(
                colors: [
                  Color(0xFF006769),
                  Color(0xFF40A578),
                  Color(0xFF9DDE8B),
                ]
            ):
            const LinearGradient(
                colors: [
                  Color(0xFF04364A),
                  Color(0xFF176B87),
                  Color(0xFF64CCC5),
                ]
            ),
            borderRadius: BorderRadius.all(Radius.circular(h>w? w*.05 : h*.05)),

        ),
        child: Center(
            child: Text(
              widget.current? widget.fullDay : widget.shortDay,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5
              ),)),
      ),
    );
  }
}
