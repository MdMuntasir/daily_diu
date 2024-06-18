import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String textHint;
  final String label;
  final bool isDigit;
  final int ? maxLen;
  const CustomTextField({super.key,
    required this.controller,
    required this.textHint,
    required this.label,
    this.maxLen,
    this.isDigit = false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: controller,
        keyboardType: isDigit ? TextInputType.number : TextInputType.text,
        inputFormatters: isDigit? [
          FilteringTextInputFormatter.digitsOnly
        ] : [],
        decoration: InputDecoration(
          hintText: textHint,
          counterText: "",
          hintStyle: TextStyle(fontSize: 18, color: Colors.black54),
          focusColor: Colors.white,
          labelText: label,
          labelStyle: TextStyle(fontSize: 22,fontWeight: FontWeight.bold, color: Colors.blue.shade900),
        ),
        cursorColor: Colors.blueAccent.shade700,
        maxLength: maxLen,
      ),
    );
  }
}
