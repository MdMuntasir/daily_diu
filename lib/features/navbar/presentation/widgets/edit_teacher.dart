import 'package:diu_student/core/resources/information_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../login system/presentation/widgets/multi_chooser.dart';
import '../../../login system/presentation/widgets/single_chooser.dart';
import 'customWidgets.dart';




class EditTeacherProfile extends StatefulWidget {
  final TextEditingController facultyController;
  final TextEditingController departmentController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController teacherInitialController;
  const EditTeacherProfile({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    required this.teacherInitialController,
    required this.facultyController,
    required this.departmentController,});

  @override
  State<EditTeacherProfile> createState() => _EditTeacherProfileState();
}

class _EditTeacherProfileState extends State<EditTeacherProfile> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;


    List<String>? departments = teacherInfo.department?.split('-');
    String dept = departments != null ? "${departments[0]}..." : "Department";


    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChooser(
                map: Faculty_Info,
                controller: widget.facultyController,
                title: teacherInfo.faculty!,
                func: () {setState(() {});},),

              SizedBox(width: w*.1,),


              MultiChooser(
                map: widget.facultyController.text == "" ? Faculty_Info[teacherInfo.faculty] : Faculty_Info[widget.facultyController.text],
                controller: widget.departmentController,
                title: dept,
              ),

            ],
          ),


          SizedBox(height: h*.02,),


          CustomForm(
            fields: [
              TextField(
                controller: widget.nameController,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z .]'))],
                decoration: InputDecoration(
                  hintText: "Name: ${teacherInfo.name}",
                  counterText: "",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
              CustomTextField(
                controller: widget.teacherInitialController,
                hintText: "Teacher Initial:  ${teacherInfo.ti}",
                maxLen: 4,
              ),


              TextField(
                controller: widget.passwordController,
                decoration: InputDecoration(
                  hintText: "Password",
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
