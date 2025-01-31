import 'package:dio/dio.dart';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/slot.dart';
import 'package:diu_student/core/util/model/slot.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_home_data.dart';
import 'package:diu_student/features/home/data/data_sources/remote/remote_home_data.dart';

import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/home/domain/repository/home_repository.dart';

class HomeRepoImplement implements HomeRepository {
  final UserEntity user;
  final RemoteHomeData remoteHomeData;
  final LocalHomeData localHomeData;
  final ConnectionChecker connectionChecker;

  const HomeRepoImplement(
    this.remoteHomeData,
    this.connectionChecker,
    this.localHomeData,
    this.user,
  );

  @override
  Future<DataState<List<SlotEntity>>> getRoutine() async {
    try {
      if (await connectionChecker.isConnected) {
        final dataState = await remoteHomeData.userRoutine(user: user);
        if (dataState is DataSuccess<List<SlotModel>>) {
          final routine = dataState.data!;
          localHomeData.uploadUserRoutine(routine: routine);
          return DataSuccess(routine);
        }
        return const DataFailed("User not found");
      } else {
        final routine = localHomeData.fetchUserRoutine();
        return DataSuccess(routine);
      }
    } on DioException catch (e) {
      return DataFailed(e.message.toString());
    }
  }
}
