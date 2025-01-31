import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MultiChooser extends StatefulWidget {
  final TextEditingController controller;
  final Map map;
  final String title;
  const MultiChooser({super.key, required this.controller, required this.map, this.title = "None"});

  @override
  State<MultiChooser> createState() => _MultiChooserState();
}

class _MultiChooserState extends State<MultiChooser> {
  bool isClicked = false;
  String selected = "";
  TextEditingController deptController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    if(selected == ""){
      selected = widget.title;
    }


    return ElevatedButton(
        onPressed: (){
          showDialog(
              context: context,
              builder: (context)=>ChooseDepartment(
                  map: widget.map,
                  controller: deptController,
                  func: (){setState(() {
                    selected = deptController.text != ""? deptController.text : "Department";
                    widget.controller.text = deptController.text;
                  });},
              ));
        },
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(Colors.blue.shade500),
            elevation: WidgetStatePropertyAll(1.5),
            shadowColor: WidgetStatePropertyAll(Colors.teal),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))))
        ),
        child: Text(
          selected == "Department"? selected : selected.split('-')[0] + '...',
          style: TextStyle(fontSize: 18),)
    );
  }
}









class ChooseDepartment extends StatefulWidget {
  final VoidCallback func;
  final TextEditingController controller;
  final Map map;
  const ChooseDepartment({super.key, required this.map, required this.controller, required this.func, });

  @override
  State<ChooseDepartment> createState() => _ChooseDepartmentState();
}

class _ChooseDepartmentState extends State<ChooseDepartment> {
  bool isClicked = false;
  Map<String,bool> boolValues = {};


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;


    if(!isClicked){
      widget.map.forEach((short, long){
        boolValues[short] = false;});
    }


    List<Widget> options = [];

    List lst = [];



    widget.map.forEach((short, long){

      lst.add([short,long]);
      options.add(CheckboxListTile(
          value: boolValues[short],
          checkboxShape: CircleBorder(),
          controlAffinity: ListTileControlAffinity.leading,
          checkColor: Colors.white,
          activeColor: Colors.blue,

          title: Text(
            long,
            style: TextStyle(
                color: Colors.blue.shade500, fontWeight: FontWeight.bold),
          ),
          onChanged: (newVal){
            boolValues[short] = !boolValues[short]!;
            setState(() {
              isClicked = true;
            });
          }));

    });



    return AlertDialog(
      content : SizedBox(
          width: w*.85,
          height: widget.map.length * h *.06 + h*.05,
          child: SingleChildScrollView(
            child: Column(children: options,),
          )
      ),
      actions: [
        ElevatedButton(
            onPressed: (){
              String temp = "";
              boolValues.forEach((dept,checked){
                if(checked){
                  temp += dept + "-";
                }
              });
              if(temp.isNotEmpty){temp = temp.substring(0,temp.length-1);}
              widget.controller.text = temp;
              widget.func();
              Navigator.pop(context);
            },
            child: Text("Done"))
      ],
    );
  }
}

