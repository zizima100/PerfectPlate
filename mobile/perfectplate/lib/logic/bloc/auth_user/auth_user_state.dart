part of 'auth_user_bloc.dart';

@immutable
abstract class AuthUserState extends Equatable {}

class AuthUserInitial extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class AuthMandatoryFieldsEmpty extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserNotFound extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class EmailInvalid extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class AuthSuccessful extends AuthUserState {
  final int id;

  AuthSuccessful(this.id);

  @override
  List<Object?> get props => [
        id
      ];
}

class AuthLoading extends AuthUserState {
  @override
  List<Object?> get props => [];
}

class UserLogout extends AuthUserState {
  @override
  List<Object?> get props => [];
}
