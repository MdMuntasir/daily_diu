import 'package:diu_student/core/util/model/user_info.dart';
import 'package:hive/hive.dart';

abstract class LocalUserData {
  void uploadUserData(UserModel user);

  UserModel fetchUserData();
}

class LocalUserDataImpl implements LocalUserData {
  final Box box;

  LocalUserDataImpl(this.box);

  @override
  UserModel fetchUserData() {
    Map data = box.get("User");
    Map<String, dynamic> userMap = Map<String, dynamic>.from(data);
    return UserModel.fromJson(userMap);
  }

  @override
  void uploadUserData(UserModel user) {
    box.put("User", UserModel().toMap(user));
  }
}
