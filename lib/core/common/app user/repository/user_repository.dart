import 'package:dio/dio.dart';
import 'package:diu_student/core/common/app%20user/data%20source/remote_user_data.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> getUser();
}

class UserRepoImpl implements UserRepository {
  final RemoteUserData remoteUserData;

  UserRepoImpl(this.remoteUserData);

  @override
  Future<DataState<UserEntity>> getUser() async {
    try {
      final dataState = await remoteUserData.userData();
      if (dataState is DataSuccess<UserEntity> && dataState.data!.user != "") {
        final userData = dataState.data!;
        return DataSuccess(userData);
      }
      return const DataFailed("User not found");
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
