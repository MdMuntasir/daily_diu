import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepoImpl implements AuthRepository {
  final AppUserCubit appUserCubit;
  final ConnectionChecker connectionChecker;
  final AuthRemoteData authRemoteData;

  const AuthRepoImpl(
    this.appUserCubit,
    this.connectionChecker,
    this.authRemoteData,
  );

  @override
  Future<DataState<UserEntity>> loginUser({
    required String email,
    required String password,
  }) async {
    if (await connectionChecker.isConnected) {
      final dataState = await authRemoteData.loginUser(
        email: email,
        password: password,
        appUserCubit: appUserCubit,
      );
      return dataState is DataSuccess<UserEntity>
          ? DataSuccess(dataState.data!)
          : DataFailed(dataState.error!);
    } else {
      return const DataFailed("No internet connection");
    }
  }

  @override
  Future<DataState<UserEntity>> signUpUser({
    required UserEntity user,
  }) {
    // TODO: implement signUpUser
    throw UnimplementedError();
  }

  @override
  Future<DataState<String>> forgotPassword({required String email}) async {
    if (await connectionChecker.isConnected) {
      if (email != "" && email.endsWith("@diu.edu.bd") ||
          email.endsWith("@daffodilvarsity.edu.bd")) {
        try {
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
          return const DataSuccess(
              "Password reset email has been sent to your mail address");
        } on FirebaseException catch (e) {
          return DataFailed(e.code.toString());
        }
      } else {
        return const DataFailed("Enter a valid email address");
      }
    } else {
      return const DataFailed("No Internet Connection");
    }
  }
}
