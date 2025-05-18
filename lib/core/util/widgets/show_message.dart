import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowAlertMessage extends StatelessWidget {
  final bool hasSucceed;
  final String text;

  const ShowAlertMessage({
    super.key,
    required this.text,
    this.hasSucceed = false,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          hasSucceed ? const Text("Succeed!") : const Text("Alert!"),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(FontAwesomeIcons.xmark))
        ],
      ),
      content: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }
}
