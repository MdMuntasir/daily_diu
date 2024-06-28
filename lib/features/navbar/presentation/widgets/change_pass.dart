import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../login system/presentation/widgets/customWidgets.dart';

class ChangePassForm extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController NewPassController;
  final TextEditingController ConfirmNewPassController;
  const ChangePassForm({
    super.key,
    required this.passwordController,
    required this.NewPassController,
    required this.ConfirmNewPassController});

  @override
  State<ChangePassForm> createState() => _ChangePassFormState();
}

class _ChangePassFormState extends State<ChangePassForm> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [

          CustomForm(
            fields: [
              TextField(
                controller: widget.passwordController,
                decoration: InputDecoration(
                  hintText: "Old Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),


              TextField(
                controller: widget.NewPassController,
                decoration: InputDecoration(
                  hintText: "New Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),


              TextField(
                controller: widget.ConfirmNewPassController,
                decoration: InputDecoration(
                  hintText: "Confirm New Password",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                obscureText: true,
              ),

            ],
          ),
        ],
      ),

    );
  }
}
