import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../home/presentation/pages/homePage.dart';

class CrossButton extends StatelessWidget {
  final Color color;

  const CrossButton({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return CloseButton(
      onPressed: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const homePage()));
      },
      color: color,
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
    );
  }
}
