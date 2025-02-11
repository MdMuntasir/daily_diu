import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';

abstract class NavRepository {
  Future<DataState> signOut();

  Future<DataState> editProfile(UserEntity user);

  Future<DataState> changePassword();
}
