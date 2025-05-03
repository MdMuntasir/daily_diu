import 'package:diu_student/config/theme/custom%20themes/bottom_panel_theme.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/features/home/presentation/widgets/customButton.dart';
import 'package:diu_student/features/routine/presentation/pages/routine_page.dart';
import 'package:diu_student/features/web%20services/pages/attendance_portal.dart';
import 'package:diu_student/features/web%20services/pages/blc_main.dart';
import 'package:diu_student/features/web%20services/pages/noticeBoard.dart';
import 'package:diu_student/features/web%20services/pages/portal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../result analysis/presentation/pages/result_page.dart';
import 'animatedBar.dart';

class BottomPanel extends StatefulWidget {
  final VoidCallback function;
  final bool controller;

  const BottomPanel({
    super.key,
    required this.controller,
    required this.function,
  });

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final theme = Theme.of(context).extension<BottomPanelTheme>()!;

    CustomButton btn1 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.calendarDays,
      function: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainRoutinePage()));
      },
      label: "Routine",
    );
    CustomButton btn2 =
        AppUserCubit().currentUser(context.read<AppUserCubit>()).user ==
                "Student"
            ? CustomButton(
                bgColor: theme.iconBgColor,
                fgColor: theme.iconFgColor,
                icon: FontAwesomeIcons.chartLine,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyResultPage()));
                },
                label: "Result",
              )
            : CustomButton(
                bgColor: theme.iconBgColor,
                fgColor: theme.iconFgColor,
                icon: FontAwesomeIcons.clipboardCheck,
                function: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AttendancePortal()));
                },
                label: "Attendance",
              );
    CustomButton btn3 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.graduationCap,
      function: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const PortalPage()));
      },
      label: "Portal",
    );
    CustomButton btn4 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.chalkboardUser,
      function: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const blcPage()));
      },
      label: "BLC",
    );
    CustomButton btn5 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.bell,
      function: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const noticeBoardPage()));
      },
      label: "Notice",
    );
    CustomButton btn6 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.info,
      function: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This feature will be available soon ing sha Allah"),
          ),
        );
      },
      label: "Info",
    );
    CustomButton btn7 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.leanpub,
      function: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This feature will be available soon ing sha Allah"),
          ),
        );
      },
      label: "Notes",
    );
    CustomButton btn8 = CustomButton(
      bgColor: theme.iconBgColor,
      fgColor: theme.iconFgColor,
      icon: FontAwesomeIcons.calendarCheck,
      function: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("This feature will be available soon ing sha Allah"),
          ),
        );
      },
      label: "Events",
    );

    void _func() {
      widget.function();
      setState(() {});
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      height: h * .65,
      width: w,
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(blurRadius: 50, spreadRadius: -48)],
        color: theme.bgColor,
        borderRadius: BorderRadius.only(
          topLeft: !widget.controller
              ? const Radius.circular(25)
              : Radius.elliptical(w, h * .2),
          topRight: !widget.controller
              ? const Radius.circular(25)
              : Radius.elliptical(w, h * .2),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              theme.bgShapeColor,
              BlendMode.srcATop,
            ),
            child: Image.asset(
              "assets/images/leaf.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: h * .03,
              ),
              AnimatedBar(
                  duration: Duration(milliseconds: 300),
                  controller: widget.controller,
                  color: theme.barColor,
                  func: _func),
              SizedBox(
                height: h * .05,
              ),
              SizedBox(
                height: h * .52,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * .1),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      spacing: w * .2,
                      runSpacing: w * .15,
                      children: [
                        btn1,
                        btn2,
                        btn3,
                        btn4,
                        btn5,
                        btn6,
                        btn7,
                        btn8
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
