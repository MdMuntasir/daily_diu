import 'package:diu_student/core/util/model/slot.dart';
import 'package:diu_student/features/routine/data/models/empty_slot_model.dart';
import 'package:hive/hive.dart';

abstract class LocalRoutineSource {
  void uploadSlotData({required List<SlotModel> slots});

  void uploadTimeData({required List times});

  void uploadEmptySlotData({required List<EmptySlotModel> emptySlots});

  List<SlotModel> fetchSlots();

  List fetchTimes();

  List<EmptySlotModel> fetchEmptySlots();
}

class LocalRoutineSourceImpl implements LocalRoutineSource {
  final String department;
  final Box box;

  LocalRoutineSourceImpl(this.box, this.department);

  @override
  List<EmptySlotModel> fetchEmptySlots() {
    List<EmptySlotModel> emptySlots = [];
    final data = box.get("$department Empty Slots");
    if (data != null) {
      for (Map map in data) {
        final slot = Map<String, dynamic>.from(map);
        emptySlots.add(EmptySlotModel.fromJson(slot));
      }
    }
    return emptySlots;
  }

  @override
  List<SlotModel> fetchSlots() {
    List<SlotModel> slots = [];
    final data = box.get("$department Slots");
    if (data != null) {
      for (Map map in data) {
        final slot = Map<String, dynamic>.from(map);
        slots.add(SlotModel.fromJson(slot));
      }
    }
    return slots;
  }

  @override
  List fetchTimes() {
    List times = [];
    final data = box.get("$department Times");
    return data ?? times;
  }

  @override
  void uploadEmptySlotData({required List<EmptySlotModel> emptySlots}) {
    List<Map<String, dynamic>> json = [];
    for (EmptySlotModel slot in emptySlots) {
      json.add(slot.toJson());
    }
    box.put("$department Empty Slots", json);
  }

  @override
  void uploadSlotData({required List<SlotModel> slots}) {
    List<Map<String, dynamic>> json = [];
    for (SlotModel slot in slots) {
      json.add(slot.toJson());
    }
    box.put("$department Slots", json);
  }

  @override
  void uploadTimeData({required List times}) {
    box.put("$department Times", times);
  }
}
