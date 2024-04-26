import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import '../../domain/repository/information_repository.dart';

class ChooseDepartment extends StatefulWidget {
  const ChooseDepartment({super.key});

  @override
  State<ChooseDepartment> createState() => _ChooseDepartmentState();
}

class _ChooseDepartmentState extends State<ChooseDepartment> {
  String selected = "SWE";
  Map departments = Information.departments;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<RadioListTile> options = [];

    departments.forEach((key, value) {
      options.add(RadioListTile(
          title: Text(value[0]),
          value: key,
          groupValue: selected,
          onChanged: (val){
            value[1];
            // setState(() {
            //   selected = val;
            // });
          }));
    });


    return ElevatedButton(
        onPressed: (){
      showPopover(
        width: w*.9,
          context: context,
          bodyBuilder: (context) => SingleChildScrollView(child: Center(child: Column(children: options,))),
        direction: PopoverDirection.top
      );
    },
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.blueAccent.shade700),
          foregroundColor: MaterialStatePropertyAll(Colors.white),
          shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))))
        ),
        child: Text(selected, style: TextStyle(fontSize: 20),)
    );
  }
}
