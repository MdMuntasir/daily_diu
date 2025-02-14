import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/navbar/Domain/repository/nav_repository.dart';

class ChangePasswordUseCase implements UseCase<dynamic, String> {
  final NavRepository _navRepository;

  const ChangePasswordUseCase(this._navRepository);

  @override
  Future<DataState> call({String? para}) async {
    return await _navRepository.changePassword(para!);
  }
}
