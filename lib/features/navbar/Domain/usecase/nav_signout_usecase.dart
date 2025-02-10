import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/usecases/usecase.dart';
import 'package:diu_student/features/navbar/Domain/repository/nav_repository.dart';

class NavSignOutUseCase implements UseCase {
  final NavRepository _navRepository;

  const NavSignOutUseCase(this._navRepository);

  @override
  Future<DataState> call({para}) {
    return _navRepository.signOut();
  }
}
