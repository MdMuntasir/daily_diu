import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';

class AuthLoginUseCase implements UseCase<UserEntity, UserLoginPara> {
  final AuthRepository authRepository;

  const AuthLoginUseCase(this.authRepository);

  @override
  Future<DataState<UserEntity>> call({UserLoginPara? para}) async {
    return await authRepository.loginUser(
      email: para!.email,
      password: para.password,
    );
  }
}

class UserLoginPara {
  final String email;
  final String password;

  UserLoginPara({
    required this.email,
    required this.password,
  });
}
