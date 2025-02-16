import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';

abstract class AuthRepository {
  Future<DataState> signUpUser({
    required UserEntity user,
  });

  Future<DataState> loginUser({
    required String email,
    required String password,
  });
}
