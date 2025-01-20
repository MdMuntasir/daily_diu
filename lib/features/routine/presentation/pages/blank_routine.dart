import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/routine/presentation/widgets/empty_slots_shower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptySlots extends StatefulWidget {
  const EmptySlots({super.key});

  @override
  State<EmptySlots> createState() => _EmptySlotsState();
}

class _EmptySlotsState extends State<EmptySlots> {



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
        child: Column(
          children: [

            EmptySlotShow(times: Times, slots: emptySlots),
          ],
        ),
    );
  }


}
