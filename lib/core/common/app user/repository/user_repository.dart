import 'package:dio/dio.dart';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/common/app%20user/data%20source/local_user_data.dart';
import 'package:diu_student/core/common/app%20user/data%20source/remote_user_data.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/core/util/model/user_info.dart';

abstract class UserRepository {
  Future<DataState<UserEntity>> getUser();
}

class UserRepoImpl implements UserRepository {
  final RemoteUserData remoteUserData;
  final LocalUserData localUserData;
  final ConnectionChecker connectionChecker;

  UserRepoImpl(
    this.remoteUserData,
    this.localUserData,
    this.connectionChecker,
  );

  @override
  Future<DataState<UserEntity>> getUser() async {
    try {
      if (await connectionChecker.isConnected) {
        final dataState = await remoteUserData.userData();
        if (dataState is DataSuccess<UserModel> && dataState.data!.user != "") {
          final userData = dataState.data!;
          localUserData.uploadUserData(userData);
          return DataSuccess(userData);
        }
        return const DataFailed("User not found");
      } else {
        final userData = localUserData.fetchUserData();
        return userData.user != ""
            ? DataSuccess(userData)
            : const DataFailed("User not found");
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
