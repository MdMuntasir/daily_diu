import 'package:diu_student/core/resources/information_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../authentication/presentation/widgets/single_chooser.dart';
import 'customWidgets.dart';

class EditStudentProfile extends StatefulWidget {
  final TextEditingController facultyController;
  final TextEditingController departmentController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final TextEditingController batchController;
  final TextEditingController sectionController;
  final TextEditingController studentIdController;

  const EditStudentProfile(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.nameController,
      required this.batchController,
      required this.sectionController,
      required this.studentIdController,
      required this.facultyController,
      required this.departmentController});

  @override
  State<EditStudentProfile> createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChooser(
                map: Faculty_Info,
                controller: widget.facultyController,
                title: studentInfo.faculty!,
                func: () {
                  setState(() {});
                },
              ),
              SizedBox(
                width: w * .1,
              ),
              SingleChooser(
                map: widget.facultyController.text == ""
                    ? {}
                    : Faculty_Info[widget.facultyController.text],
                controller: widget.departmentController,
                title: studentInfo.department!,
                func: () {},
              ),
            ],
          ),
          SizedBox(
            height: h * .02,
          ),
          CustomForm(
            fields: [
              TextField(
                controller: widget.nameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z .]'))
                ],
                decoration: InputDecoration(
                  hintText: "Name:  ${studentInfo.name}",
                  counterText: "",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
              CustomTextField(
                controller: widget.batchController,
                hintText: "Batch:   ${studentInfo.batch}",
                isDigit: true,
                maxLen: 2,
              ),
              CustomTextField(
                controller: widget.sectionController,
                hintText: "Section:  ${studentInfo.section}",
                maxLen: 2,
              ),
              TextField(
                controller: widget.studentIdController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9-]'))
                ],
                decoration: InputDecoration(
                  hintText: "ID:  ${studentInfo.studentID}",
                  counterText: "",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
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
