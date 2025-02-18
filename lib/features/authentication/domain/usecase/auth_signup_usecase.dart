import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';

class AuthSignUpUseCase implements UseCase<UserEntity, void> {
  final AuthRepository authRepository;

  const AuthSignUpUseCase(this.authRepository);

  @override
  Future<DataState<UserEntity>> call({void para}) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
