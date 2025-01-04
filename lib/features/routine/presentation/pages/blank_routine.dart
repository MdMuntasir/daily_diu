
import 'package:diu_student/core/resources/information_repository.dart';
import 'package:diu_student/features/routine/domain/usecases/empty%20slot/empty_slot_usercase.dart';
import 'package:diu_student/features/routine/presentation/widgets/empty_slots_shower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../../../../injection_container.dart';

class EmptySlots extends StatefulWidget {
  const EmptySlots({super.key});

  @override
  State<EmptySlots> createState() => _EmptySlotsState();
}

class _EmptySlotsState extends State<EmptySlots> {



  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;




    return SingleChildScrollView(
        child: Column(
          children: [

            EmptySlotShow(times: Times, slots: emptySlots),
          ],
        ),
    );
  }


}
