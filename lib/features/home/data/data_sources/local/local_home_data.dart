import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';

abstract class LocalHomeData {
  void uploadUserRoutine();

  List<SlotEntity> fetchUserRoutine();
}
