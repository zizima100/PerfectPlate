import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/data/repositories/authentication_repository.dart';

part 'auth_user_event.dart';
part 'auth_user_state.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  final AuthenticationRepository _respository = AuthenticationRepository();

  AuthUserBloc() : super(AuthUserInitial()) {
    on<LoginUserStartedEvent>(_onLoginUserStarted);
    on<SingUpUserStartedEvent>(_onSignUpUserStarted);
    on<LogoutStartedEvent>(_onLogoutStarted);
  }

  Future<void> _onLoginUserStarted(
    LoginUserStartedEvent event,
    Emitter<AuthUserState> emit,
  ) async {
    try {
      emit(AuthLoading());
      _validateLoginUser(event);
      int? userId = await _respository.loginUser(event.user);
      emit(AuthSuccessful(userId!));
    } on MandatoryAuthFieldsEmptyException catch (_) {
      emit(AuthMandatoryFieldsEmpty());
    } on UserNotFoundException catch (_) {
      emit(UserNotFound());
    }
  }

  void _validateLoginUser(LoginUserStartedEvent event) {
    if (event.user.email.trim().isEmpty || event.user.password.trim().isEmpty) {
      throw MandatoryAuthFieldsEmptyException();
    }
  }

  Future<void> _onSignUpUserStarted(SingUpUserStartedEvent event, Emitter<AuthUserState> emit) async {
    try {
      emit(AuthLoading());
      _validateSignUpUser(event);
      int? userId = await _respository.singupUser(event.user);
      emit(AuthSuccessful(userId!));
    } on MandatoryAuthFieldsEmptyException catch (_) {
      emit(AuthMandatoryFieldsEmpty());
    } on EmailAlreadyExists catch (_) {
      emit(EmailInvalid());
    }
  }

  void _validateSignUpUser(SingUpUserStartedEvent event) {
    if (event.user.name.isEmpty 
      || event.user.email.isEmpty 
      || event.user.password.isEmpty
      || event.user.age.isEmpty
      || event.user.height.isEmpty
      || event.user.weight.isEmpty
      || event.user.sex.isEmpty
    ) {
      throw MandatoryAuthFieldsEmptyException();
    }
  }

  _onLogoutStarted(_, Emitter<AuthUserState> emit) {
    emit(UserLogout());
  }
}
