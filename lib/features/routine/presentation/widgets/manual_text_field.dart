import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../../config/theme/custom themes/routine_theme.dart';

class ManualTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool isDigit;
  final int? maxLen;

  const ManualTextField(
      {super.key,
      required this.controller,
      required this.title,
      this.isDigit = false,
      this.maxLen});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).extension<RoutineTheme>()!;

    double space = w * .05;

    return SizedBox(
      width: w * .7,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title + " : ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 16),
          ),
          SizedBox(
            width: space,
          ),
          SizedBox(
            width: w * .3,
            height: h * .05,
            child: TextField(
              controller: controller,
              keyboardType: isDigit ? TextInputType.number : TextInputType.text,
              inputFormatters: isDigit
                  ? [FilteringTextInputFormatter.digitsOnly]
                  : [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z0-9\-]')),
                    ],
              cursorColor: theme.deepColor,
              style: TextStyle(
                  color: theme.deepColor, fontWeight: FontWeight.bold),
              maxLength: maxLen,
            ),
          )
        ],
      ),
    );
  }
}
