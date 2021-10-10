part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthUsernameChangedEvent extends AuthEvent {
  const AuthUsernameChangedEvent({required this.username});

  final String username;

  @override
  List<Object> get props => [username];
}

class AuthEmailChangedEvent extends AuthEvent {
  const AuthEmailChangedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class AuthPasswordChangedEvent extends AuthEvent {
  const AuthPasswordChangedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class AuthModeSwitchedEvent extends AuthEvent {}

class AuthenticatedEvent extends AuthEvent {}
