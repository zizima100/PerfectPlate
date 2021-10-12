import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/data/repositories/authentication_repository.dart';

part 'auth_user_event.dart';
part 'auth_user_state.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  final AuthenticationRespository respository = AuthenticationRespository();

  AuthUserBloc() : super(AuthUserInitial()) {
    on<LoginUserStarted>(_onLoginUserStarted);
    on<SingUpUserStarted>(_onSignUpUserStarted);
  }

  Future<void> _onLoginUserStarted(
    LoginUserStarted event,
    Emitter<AuthUserState> emit,
  ) async {
    try {
      _validateLoginUser(event);
      await respository.loginUser(event.user);
      emit(AuthSuccessful());
    } on MandatoryAuthFieldsEmptyException catch (_) {
      emit(AuthMandatoryFieldsEmpty());
    }
  }

  void _validateLoginUser(LoginUserStarted event) {
    if (event.user.email.trim().isEmpty || event.user.password.trim().isEmpty) {
      throw MandatoryAuthFieldsEmptyException();
    }
  }

  Future<void> _onSignUpUserStarted(
      SingUpUserStarted event, Emitter<AuthUserState> emit) async {
    try {
      _validateSignUpUser(event);
      await respository.singupUser(event.user);
      emit(AuthSuccessful());
    } on MandatoryAuthFieldsEmptyException catch (_) {
      emit(AuthMandatoryFieldsEmpty());
    }
  }

  void _validateSignUpUser(SingUpUserStarted event) {
    if (event.user.email.trim().isEmpty ||
        event.user.email.trim().isEmpty ||
        event.user.password.trim().isEmpty) {
      throw MandatoryAuthFieldsEmptyException();
    }
  }
}
