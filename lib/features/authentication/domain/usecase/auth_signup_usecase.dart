import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';

class AuthSignUpUseCase implements UseCase<UserEntity, SignUpPara> {
  final AuthRepository authRepository;

  const AuthSignUpUseCase(this.authRepository);

  @override
  Future<DataState<UserEntity>> call({SignUpPara? para}) async {
    return await authRepository.signUpUser(
      user: para!.user,
      confirmPassword: para.confirmPassword,
    );
  }
}

class SignUpPara {
  final UserEntity user;
  final String confirmPassword;

  const SignUpPara({
    required this.user,
    required this.confirmPassword,
  });
}
