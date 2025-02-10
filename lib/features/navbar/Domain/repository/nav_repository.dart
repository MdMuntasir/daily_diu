import 'package:diu_student/core/resources/data_state.dart';

abstract class NavRepository {
  Future<DataState> signOut();

  Future<DataState> editProfile();
}
