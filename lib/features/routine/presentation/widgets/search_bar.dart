import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/custom themes/routine_theme.dart';

class CustomSearchBar extends StatefulWidget {
  final bool enable;
  final TextEditingController controller;
  final String hint;
  final VoidCallback onSearch;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hint = "",
    required this.onSearch,
    this.enable = true,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    final theme = Theme.of(context).extension<RoutineTheme>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: w * .05,
      children: [
        Container(
          width: w * .78,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: widget.enable ? theme.bgColor : theme.inactiveBgColor,
                width: 1.5,
              )),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            child: TextField(
              enabled: widget.enable,
              controller: widget.controller,
              showCursor: true,
              maxLength: 5,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\-]')),
              ],
              style: TextStyle(color: theme.deepColor),
              decoration: InputDecoration(
                counterText: "",
                hintText: widget.hint,
                hintStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: widget.enable ? theme.bgColor : theme.inactiveBgColor),
          child: IconButton(
              onPressed: widget.onSearch,
              icon: Icon(
                Icons.search,
                color: theme.fgColor,
              )),
        )
      ],
    );
  }
}
