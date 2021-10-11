part of 'auth_user_bloc.dart';

@immutable
abstract class AuthUserEvent {}

class LoginUserStarted extends AuthUserEvent {
  final LoginUser user;
  LoginUserStarted(this.user);
}
