import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/common/app%20user/data%20source/local_user_data.dart';
import 'package:diu_student/core/common/app%20user/data%20source/remote_user_data.dart';
import 'package:diu_student/core/common/app%20user/repository/user_repository.dart';
import 'package:diu_student/core/common/app%20user/usecase/user_usecase.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/core/util/model/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(InitialAppUser());

  Future<void> updateUser() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    await currentUser?.reload();
    if (currentUser == null) {
      emit(LoggedOutAppUser());
    } else {
      if (currentUser.emailVerified) {
        final user = await UserUseCase(UserRepoImpl(
          RemoteUserDataImpl(),
          LocalUserDataImpl(Hive.box("UserInfo")),
          ConnectionCheckerImpl(InternetConnection.createInstance()),
        )).call();
        if (user is DataSuccess<UserEntity>) {
          emit(LoggedAppUser(user.data!));
        } else {
          emit(UserFetchFailure(user.error!));
        }
      } else {
        emit(UnverifiedUser());
      }
    }
  }

  UserEntity currentUser(AppUserCubit cubit) {
    final state = cubit.state;
    final user = state is LoggedAppUser ? state.user : const UserModel();
    return user;
  }
}
