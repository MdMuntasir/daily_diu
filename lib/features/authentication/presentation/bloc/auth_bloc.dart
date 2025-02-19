import 'dart:async';

import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_forgot_pass_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_login_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_signup_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_verify_usecase.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_event.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUseCase authLoginUseCase;
  final AuthSignUpUseCase authSignUpUseCase;
  final AuthForgotPassUseCase authForgotPassUseCase;
  final AuthVerifyUseCase authVerifyUseCase;

  AuthBloc({
    required this.authVerifyUseCase,
    required this.authSignUpUseCase,
    required this.authForgotPassUseCase,
    required this.authLoginUseCase,
  }) : super(AuthInitialState()) {
    on<AuthInitialEvent>(authInitialEvent);
    on<AuthLoginEvent>(authLoginEvent);
    on<AuthLoginForgotPasswordEvent>(authLoginForgotPasswordEvent);
    on<AuthSignUpEvent>(authSignUpEvent);
    on<AuthVerifyEvent>(authVerifyEvent);
  }

  FutureOr<void> authInitialEvent(
    AuthInitialEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitialState());
  }

  FutureOr<void> authLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoginLoading());
    final dataState = await authLoginUseCase(
        para: UserLoginPara(
      email: event.email,
      password: event.password,
    ));
    if (dataState is DataSuccess) {
      dataState.data!.verified == true
          ? emit(AuthLoginSucceed(dataState.data!))
          : emit(AuthLoginNotVerified(dataState.data!));
    } else {
      emit(AuthLoginFailed(dataState.error!));
    }
  }

  FutureOr<void> authLoginForgotPasswordEvent(
    AuthLoginForgotPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    final dataState = await authForgotPassUseCase(para: event.email);

    emit(AuthLoginForgotPassword(
        dataState is DataSuccess ? dataState.data! : dataState.error!));
  }

  FutureOr<void> authSignUpEvent(
    AuthSignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthSignUpLoading());
    final dataState = await authSignUpUseCase(
        para: SignUpPara(
      user: event.user,
      confirmPassword: event.confirmPassword,
    ));
    if (dataState is DataSuccess) {
      emit(AuthSignUpSucceed(dataState.data!));
    } else {
      emit(AuthSignUpFailed(dataState.error!));
    }
  }

  FutureOr<void> authVerifyEvent(
      AuthVerifyEvent event, Emitter<AuthState> emit) async {
    emit(AuthVerificationLoading());
    final dataState = await authVerifyUseCase(
      para: event.user,
    );
    if (dataState is DataSuccess) {
      emit(AuthVerifiedState(dataState.data.toString()));
    } else {
      emit(AuthVerificationFailed(dataState.error.toString()));
    }
  }
}
