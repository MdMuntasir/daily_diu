import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';

class AuthVerifyUseCase implements UseCase<String, UserEntity> {
  final AuthRepository authRepository;

  const AuthVerifyUseCase(this.authRepository);

  @override
  Future<DataState<String>> call({UserEntity? para}) async {
    return await authRepository.verifyUser(user: para!);
  }
}
