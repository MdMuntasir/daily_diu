import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/navbar/Domain/repository/nav_repository.dart';

class EditProfileUseCase implements UseCase<dynamic, UserEntity> {
  final NavRepository _navRepository;

  const EditProfileUseCase(this._navRepository);

  @override
  Future<DataState> call({UserEntity? para}) async {
    return await _navRepository.editProfile(para!);
  }
}
