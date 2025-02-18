import 'dart:async';

import 'package:diu_student/core/resources/data_state.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_forgot_pass_usecase.dart';
import 'package:diu_student/features/authentication/domain/usecase/auth_login_usecase.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_event.dart';
import 'package:diu_student/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthLoginUseCase authLoginUseCase;
  final AuthForgotPassUseCase authForgotPassUseCase;

  AuthBloc({
    required this.authForgotPassUseCase,
    required this.authLoginUseCase,
  }) : super(AuthInitialState()) {
    on<AuthInitialEvent>(authInitialEvent);
    on<AuthLoginEvent>(authLoginEvent);
    on<AuthLoginConfirmEvent>(authLoginConfirmEvent);
    on<AuthLoginForgotPasswordEvent>(authLoginForgotPasswordEvent);
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
  ) {
    emit(AuthLoginState(
      email: event.email,
      password: event.password,
    ));
  }

  FutureOr<void> authLoginConfirmEvent(
    AuthLoginConfirmEvent event,
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
}
