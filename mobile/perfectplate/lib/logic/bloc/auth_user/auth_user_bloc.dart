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
  }

  Future<void> _onLoginUserStarted(
    LoginUserStarted event,
    Emitter<AuthUserState> emit,
  ) async {
    try {
      _validateLoginUser(event, emit);
      await respository.loginUser(event.user);
    } on MandatoryAuthFieldsEmptyException catch (_) {
      emit(AuthMandatoryFieldsEmpty());
    }
  }

  void _validateLoginUser(LoginUserStarted event, Emitter<AuthUserState> emit) {
    if (event.user.email.trim().isEmpty || event.user.password.trim().isEmpty) {
      throw MandatoryAuthFieldsEmptyException();
    }
  }

  // Future<void> signUpUser() async {
  //   if (state.username.trim().isEmpty ||
  //       state.email.trim().isEmpty ||
  //       state.password.trim().isEmpty) {
  //     add(AuthMandatoryFieldsEmpty());
  //   }
  //   try {
  //     await respository.singupUser(SingUpUser(
  //       state.username,
  //       state.email,
  //       state.password,
  //     ));
  //   } on Exception catch (e) {
  //     // TODO
  //   }
  // }
}
