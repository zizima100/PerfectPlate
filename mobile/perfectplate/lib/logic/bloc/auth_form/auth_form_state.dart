part of 'auth_form_bloc.dart';

class AuthFormState extends Equatable {
  final String email;
  final String password;
  final String username;
  final AuthMode mode;

  const AuthFormState({
    required this.email,
    required this.password,
    required this.username,
    required this.mode,
  });

  @override
  List<Object?> get props => [email, password, username, mode];

  AuthFormState copyWith(
      {String? email,
      String? password,
      String? username,
      AuthMode? mode,
      bool? mandatoryFieldsEmpty}) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      mode: mode ?? this.mode,
    );
  }
}

class AuthInitial extends AuthFormState {
  AuthInitial()
      : super(
          email: '',
          password: '',
          username: '',
          mode: AuthMode(Mode.login),
        );

  @override
  List<Object?> get props => [];
}
