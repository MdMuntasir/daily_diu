import 'package:diu_student/features/routine/domain/entities/empty_slot.dart';
import 'package:diu_student/features/routine/presentation/widgets/empty_slots_shower.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptySlots extends StatefulWidget {
  final List times;
  final List<EmptySlotEntity> emptySlots;

  const EmptySlots({super.key, required this.times, required this.emptySlots});

  @override
  State<EmptySlots> createState() => _EmptySlotsState();
}

class _EmptySlotsState extends State<EmptySlots> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          EmptySlotShow(
            times: widget.times,
            slots: widget.emptySlots,
          ),
        ],
      ),
    );
  }
}
