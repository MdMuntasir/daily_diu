import 'package:diu_student/config/theme/custom%20themes/form_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomForm extends StatefulWidget {
  final List<Widget> fields;
  final int duration;

  const CustomForm({super.key, required this.fields, this.duration = 300});

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).extension<FormTheme>()!;

    return AnimatedContainer(
      height: h * .08 * widget.fields.length,
      width: w * .85,
      duration: Duration(milliseconds: widget.duration),
      decoration: BoxDecoration(
        color: theme.bgColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor,
            blurRadius: 20,
            spreadRadius: -10,
          )
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: widget.fields.map((field) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xffeeeeee))),
              ),
              child: field,
            );
          }).toList(),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color hintColor;
  final bool obscureText;
  final bool isDigit;
  final int? maxLen;

  const CustomTextField(
      {super.key,
      required this.controller,
      this.hintText = "Password",
      this.hintColor = Colors.grey,
      this.obscureText = false,
      this.isDigit = false,
      this.maxLen});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<FormTheme>()!;
    return TextField(
      style: TextStyle(color: theme.deepColor),
      controller: controller,
      keyboardType: isDigit ? TextInputType.number : TextInputType.text,
      inputFormatters: isDigit ? [FilteringTextInputFormatter.digitsOnly] : [],
      maxLength: maxLen,
      decoration: InputDecoration(
        hintText: hintText,
        counterText: "",
        hintStyle: TextStyle(color: hintColor),
        border: InputBorder.none,
      ),
      obscureText: obscureText,
    );
  }
}
