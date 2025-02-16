import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/features/home/presentation/widgets/customText.dart';
import 'package:flutter/material.dart';

import '../../../../core/util/model/slot.dart';

class SlotShower extends StatefulWidget {
  final SlotEntity slots; // change path later
  final bool isActive;

  const SlotShower({
    super.key,
    required this.slots,
    this.isActive = false,
  });

  @override
  _SlotShowerState createState() => _SlotShowerState();
}

class _SlotShowerState extends State<SlotShower> {
  final Duration _duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool horizontal = h > w;

    double mainHeight = horizontal ? h * .23 : w * .23;
    double mainWidth = horizontal ? w * .7 : h * .7;
    double round = 20;

    SlotEntity slots = widget.slots;
    bool now = widget.isActive;

    return Container(
      width: mainWidth,
      height: mainHeight,
      color: Colors.transparent,
      child: Column(
        children: [
          AnimatedContainer(
            duration: _duration,
            height: mainHeight * .22,
            width: mainWidth,
            decoration: BoxDecoration(
                gradient: now
                    ? const LinearGradient(colors: [
                        Color(0xFF006769),
                        Color(0xFF40A578),
                        Color(0xFF9DDE8B),
                      ])
                    : const LinearGradient(colors: [
                        Color(0xFF04364A),
                        Color(0xFF176B87),
                        Color(0xFF64CCC5),
                      ]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(round),
                    topRight: Radius.circular(round)),
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: -10,
                      blurRadius: 15,
                      offset: Offset(0, 1),
                      color: Colors.black87)
                ]),
            child: Center(
                child: Text(
              slots.time!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5,
                  color: Colors.white,
                  fontFamily: "Madimi",
                  shadows: [
                    Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                        offset: Offset(1, 1.5))
                  ]),
            )),
          ),
          Divider(
            height: mainHeight * .03,
            color: Colors.transparent,
          ),
          AnimatedContainer(
            duration: _duration,
            height: mainHeight * .70,
            width: mainWidth,
            decoration: BoxDecoration(
                gradient: now
                    ? const LinearGradient(colors: [
                        Color(0xFF006769),
                        Color(0xFF40A578),
                        Color(0xFF9DDE8B),
                      ])
                    : const LinearGradient(colors: [
                        Color(0xFF04364A),
                        Color(0xFF176B87),
                        Color(0xFF64CCC5),
                      ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(round),
                    bottomRight: Radius.circular(round)),
                boxShadow: const [
                  BoxShadow(
                      spreadRadius: -12,
                      blurRadius: 20,
                      offset: Offset(1, 3),
                      color: Colors.black87)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: mainWidth * .1, vertical: mainHeight * .05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    first: "Course",
                    second: slots.course!,
                    size: 15,
                    color: Colors.white,
                    fontFamily: "Madimi",
                  ),
                  CustomText(
                    first: "Room",
                    second: slots.room!,
                    size: 15,
                    color: Colors.white,
                    fontFamily: "Madimi",
                  ),
                  CustomText(
                    first: "Section",
                    second: "${slots.batch}_${slots.section!}",
                    size: 15,
                    color: Colors.white,
                    fontFamily: "Madimi",
                  ),
                  CustomText(
                    first: "Teacher",
                    second: slots.ti!,
                    size: 15,
                    color: Colors.white,
                    fontFamily: "Madimi",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
