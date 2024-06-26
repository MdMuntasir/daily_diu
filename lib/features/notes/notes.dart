import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class notePage extends StatefulWidget {
  const notePage({super.key});

  @override
  State<notePage> createState() => _notePageState();
}

class _notePageState extends State<notePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Coming Soon...",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: Colors.green.shade700
          ),
        ),
      ),
    );
  }
}
