import 'package:diu_student/core/common/app%20user/repository/user_repository.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';

class UserUseCase implements UseCase<UserEntity, void> {
  final UserRepository userRepository;

  const UserUseCase(this.userRepository);

  @override
  Future<DataState<UserEntity>> call({void para}) async {
    return await userRepository.getUser();
  }
}
