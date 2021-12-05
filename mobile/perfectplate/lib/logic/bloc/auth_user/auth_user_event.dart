part of 'auth_user_bloc.dart';

@immutable
abstract class AuthUserEvent {}

class LoginUserStartedEvent extends AuthUserEvent {
  final LoginUser user;
  LoginUserStartedEvent(this.user);
}

class SingUpUserStartedEvent extends AuthUserEvent {
  final SingUpUser user;
  SingUpUserStartedEvent(this.user);

  @override
  String toString() => 'SingUpUserStartedEvent(user: $user)';
}

@immutable
class LogoutStartedEvent extends AuthUserEvent {}
