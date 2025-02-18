import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';

class AuthForgotPassUseCase implements UseCase<String, String> {
  final AuthRepository authRepository;

  const AuthForgotPassUseCase(this.authRepository);

  @override
  Future<DataState<String>> call({String? para}) async {
    return await authRepository.forgotPassword(email: para!);
  }
}
