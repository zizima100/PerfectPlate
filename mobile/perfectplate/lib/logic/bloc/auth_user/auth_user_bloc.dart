import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:perfectplate/core/exceptions/auth_exceptions.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/data/repositories/authentication_repository.dart';
import 'package:perfectplate/data/repositories/cache_map_repository.dart';

part 'auth_user_event.dart';
part 'auth_user_state.dart';

class AuthUserBloc extends Bloc<AuthUserEvent, AuthUserState> {
  final AuthenticationRepository _respository = AuthenticationRepository();
  final CacheMapRepository _cacheMapRepository = CacheMapRepository();
  final User _user;

  AuthUserBloc(this._user) : super(AuthUserInitial()) {
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
      Map? userData = await _respository.loginUser(event.user);
      int userId = userData!['id'];
      _user.id = userId;
      await _cacheMapRepository.setUserId(userId);
      emit(AuthSuccessful(userId));
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

  Future<void> _onSignUpUserStarted(
      SingUpUserStartedEvent event, Emitter<AuthUserState> emit) async {
    try {
      emit(AuthLoading());
      _validateSignUpUser(event);
      int? userId = await _respository.singupUser(event.user);
      await _cacheMapRepository.setUserId(userId);
      _user.id = userId;
      emit(AuthSuccessful(userId!));
    } on MandatoryAuthFieldsEmptyException catch (_) {
      emit(AuthMandatoryFieldsEmpty());
    } on EmailAlreadyExists catch (_) {
      emit(EmailInvalid());
    }
  }

  void _validateSignUpUser(SingUpUserStartedEvent event) {
    print('SingUpUserStartedEvent = $event');
    if (event.user.name.isEmpty ||
        event.user.email.isEmpty ||
        event.user.password.isEmpty ||
        event.user.age.isEmpty ||
        event.user.height.isEmpty ||
        event.user.weight.isEmpty ||
        event.user.sex.isEmpty) {
      throw MandatoryAuthFieldsEmptyException();
    }
  }

  Future<void> _onLogoutStarted(_, Emitter<AuthUserState> emit) async {
    await _cacheMapRepository.userLogout();
    _user.id = null;
    emit(UserLogout());
  }

  Future<int?> retrieveUserIdCache() async {
    await _cacheMapRepository.init();
    return _cacheMapRepository.retrieveUserIdCache();
  }

  void mapUserId(int id) {
    _user.id = id;
  }
}
