import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// custom neomorphic form
class CustomForm extends StatelessWidget {
  final List<TextField> fields;

  CustomForm({required this.fields});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(27, 95, 225, 0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Column(
          children: fields.map((field) {
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

// custom text field
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Color hintColor;
  final bool obscureText;

  const CustomTextField({
    Key? key,
    required this.controller,
    this.hintText = "Password",
    this.hintColor = Colors.grey,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffeeeeee))),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: hintColor),
          border: InputBorder.none,
        ),
        obscureText: obscureText,
      ),
    );
  }
}
