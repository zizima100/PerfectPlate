class AuthMode {
  final Mode _mode;

  AuthMode(this._mode);

  bool isLogin() {
    return _mode == Mode.login;
  }

  bool isSignup() {
    return _mode == Mode.signup;
  }

  AuthMode switchMode() {
    return isLogin() ? AuthMode(Mode.signup) : AuthMode(Mode.login);
  }
}

enum Mode { login, signup }
