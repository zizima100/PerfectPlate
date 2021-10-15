part of 'auth_user_bloc.dart';

@immutable
abstract class AuthUserState {}

class AuthUserInitial extends AuthUserState {}

class AuthMandatoryFieldsEmpty extends AuthUserState {}

class UserNotFound extends AuthUserState {}

class AuthSuccessful extends AuthUserState {}
