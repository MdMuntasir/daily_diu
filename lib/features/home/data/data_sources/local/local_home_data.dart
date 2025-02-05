import 'package:diu_student/core/util/model/slot.dart';
import 'package:hive/hive.dart';

abstract class LocalHomeData {
  void uploadUserRoutine({required List<SlotModel> routine});

  List<SlotModel> fetchUserRoutine();
}

class LocalHomeDataImpl implements LocalHomeData {
  final Box box;

  const LocalHomeDataImpl(this.box);

  @override
  List<SlotModel> fetchUserRoutine() {
    List<SlotModel> slots = [];
    List data = box.get("UserRoutine");
    for (Map map in data) {
      final slot = Map<String, dynamic>.from(map);
      slots.add(SlotModel.fromJson(slot));
    }
    return slots;
  }

  @override
  void uploadUserRoutine({required List<SlotModel> routine}) {
    List<Map<String, dynamic>> json = [];
    for (SlotModel slot in routine) {
      json.add(slot.toJson());
    }
    box.put("UserRoutine", json);
  }
}
