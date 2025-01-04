import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  final bool enable;
  final TextEditingController controller;
  final String hint;
  final VoidCallback onSearch;
  const CustomSearchBar({super.key, required this.controller, this.hint="", required this.onSearch, this.enable=true});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: w*.05,
      
      children: [
        Container(
          width: w*.78,
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: widget.enable ? Colors.teal : Colors.grey,
              width: 1.5,
            )
          ),
        
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
            child: TextField(
              enabled: widget.enable,
              controller: widget.controller,
              showCursor: true,
              style: TextStyle(color: Colors.teal.shade900),
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
        
            ),
          ),
        ),
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: widget.enable? Colors.teal : Colors.grey
          ),
          child: IconButton(onPressed: widget.onSearch, icon: Icon(Icons.search, color: Colors.white,)),
        )
      ],
    );
  }
}
