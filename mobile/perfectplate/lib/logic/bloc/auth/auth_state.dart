part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final String username;
  final AuthMode mode;

  const AuthState({
    required this.email,
    required this.password,
    required this.username,
    required this.mode,
  });

  @override
  List<Object?> get props => [email, password, username, mode];

  AuthState copyWith({
    String? email,
    String? password,
    String? username,
    AuthMode? mode,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      username: username ?? this.username,
      mode: mode ?? this.mode,
    );
  }
}

class AuthInitial extends AuthState {
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
