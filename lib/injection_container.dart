import 'package:diu_student/core/Network/connection_checker.dart';
import 'package:diu_student/core/common/app%20user/userCubit/app_user_cubit.dart';
import 'package:diu_student/core/util/Entities/user_info.dart';
import 'package:diu_student/features/authentication/data/data%20sources/auth_remote_data_source.dart';
import 'package:diu_student/features/authentication/data/repository/auth_repo_impl.dart';
import 'package:diu_student/features/authentication/domain/repository/auth_repository.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_forgot_pass_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_login_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_signup_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_verify_usecase.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:diu_student/features/home/data/data_sources/local/local_home_data.dart';
import 'package:diu_student/features/home/data/data_sources/remote/remote_home_data.dart';
import 'package:diu_student/features/home/data/repository/home_repo_implement.dart';
import 'package:diu_student/features/home/domain/repository/home_repository.dart';
import 'package:diu_student/features/home/domain/usecases/home_usecase.dart';
import 'package:diu_student/features/home/presentation/state/home_bloc.dart';
import 'package:diu_student/features/navbar/Data/repository/nav_repo_implement.dart';
import 'package:diu_student/features/navbar/Domain/repository/nav_repository.dart';
import 'package:diu_student/features/navbar/Domain/usecase/nav_change_password_usecase.dart';
import 'package:diu_student/features/navbar/Domain/usecase/nav_editprofile_usecase.dart';
import 'package:diu_student/features/navbar/Domain/usecase/nav_signout_usecase.dart';
import 'package:diu_student/features/navbar/presentation/state/nav_bloc.dart';
import 'package:diu_student/features/result%20analysis/presentation/state/result_bloc.dart';
import 'package:diu_student/features/routine/presentation/state/routine_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import 'core/remote info/get_info.dart';
import 'firebase_options.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependency() async {
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox("routine_box");
  await Hive.openBox("UserInfo");
  await Hive.openBox("Results");
  await Hive.openBox("Routine");
  await getApiLink();

  await AppUserCubit().updateUser();

  _initAuth();
  _initNavbar([Hive.box("UserInfo"), Hive.box("Results")]);
  _initResult(Hive.box("Results"));
  _initRoutine(Hive.box("Routine"));
  _initHome(Hive.box("Routine"));

  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(serviceLocator()),
  );

  serviceLocator.registerLazySingleton<AppUserCubit>(
    () => AppUserCubit(),
  );

  serviceLocator.registerFactory<UserEntity>(
      () => AppUserCubit().currentUser(serviceLocator()));
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteData>(() => AuthRemoteDataImpl())
    ..registerFactory<AuthRepository>(() => AuthRepoImpl(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerFactory<AuthForgotPassUseCase>(() => AuthForgotPassUseCase(
          serviceLocator(),
        ))
    ..registerFactory<AuthLoginUseCase>(() => AuthLoginUseCase(
          serviceLocator(),
        ))
    ..registerFactory<AuthSignUpUseCase>(() => AuthSignUpUseCase(
          serviceLocator(),
        ))
    ..registerFactory<AuthVerifyUseCase>(() => AuthVerifyUseCase(
          serviceLocator(),
        ))
    ..registerLazySingleton(() => AuthBloc(
        authSignUpUseCase: serviceLocator(),
        authForgotPassUseCase: serviceLocator(),
        authLoginUseCase: serviceLocator(),
        authVerifyUseCase: serviceLocator()));
}

void _initNavbar(List<Box> boxes) {
  serviceLocator
    ..registerFactory<NavRepository>(() => NavRepoImpl(
          boxes,
          serviceLocator(),
        ))
    ..registerFactory<NavSignOutUseCase>(() => NavSignOutUseCase(
          serviceLocator(),
        ))
    ..registerFactory<EditProfileUseCase>(() => EditProfileUseCase(
          serviceLocator(),
        ))
    ..registerFactory<ChangePasswordUseCase>(() => ChangePasswordUseCase(
          serviceLocator(),
        ))
    ..registerLazySingleton(() => NavBloc(
        user: serviceLocator(),
        navSignOutUseCase: serviceLocator(),
        editProfileUseCase: serviceLocator(),
        changePasswordUseCase: serviceLocator()));
}

void _initResult(Box box) {
  serviceLocator
      .registerLazySingleton(() => ResultBloc(user: serviceLocator()));
}

void _initRoutine(Box routineBox) {
  serviceLocator.registerLazySingleton(() => RoutineBloc());
}

void _initHome(Box routineBox) {
  serviceLocator
    ..registerFactory<LocalHomeData>(() => LocalHomeDataImpl(
          routineBox,
        ))
    ..registerFactory<RemoteHomeData>(
      () => RemoteHomeDataImpl(),
    )
    ..registerFactory<HomeRepository>(() => HomeRepoImplement(
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
          serviceLocator(),
        ))
    ..registerFactory(() => HomeUseCase(
          serviceLocator(),
        ))
    ..registerLazySingleton(() => HomeBloc(
          homeUseCase: serviceLocator(),
          appUserCubit: serviceLocator(),
        ));
}
