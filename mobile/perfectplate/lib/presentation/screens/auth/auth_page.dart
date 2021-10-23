import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/router/routes.dart';
import 'package:sizer/sizer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: AuthWidget(),
    );
  }
}

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  _AuthWidgetState createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  void _showSnackBarError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade100,
        duration: Duration(milliseconds: 1500),
        content: Text(
          message,
          style: TextStyle(
            color: Colors.red.shade900,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthUserBloc, AuthUserState>(
      listener: (context, state) {
        if (state is AuthMandatoryFieldsEmpty) {
          _showSnackBarError(ErrorMessagesConstants.mandatoryFieldsEmpty);
        }
        if (state is UserNotFound) {
          _showSnackBarError(ErrorMessagesConstants.userNotFound);
        }
        if (state is EmailInvalid) {
          _showSnackBarError(ErrorMessagesConstants.emailAlreadyExists);
        }
        if (state is AuthSuccessful) {
          BlocProvider.of<PlatesBloc>(context)
              .add(UserAuthenticated(userId: state.id));
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.home,
            (Route<dynamic> route) => false,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[50],
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(3.w),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    ImageConstants.logoImage,
                    fit: BoxFit.fill,
                    height: 30.h,
                  ),
                  AuthFormWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AuthFormWidget extends StatefulWidget {
  const AuthFormWidget({Key? key}) : super(key: key);

  @override
  _AuthFormWidgetState createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  late String email;
  late String password;
  late String username;
  late AuthMode mode;
  late AuthUserBloc authUserBloc;

  @override
  void initState() {
    email = '';
    password = '';
    username = '';
    mode = AuthMode(Mode.login);
    authUserBloc = BlocProvider.of<AuthUserBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.w),
          child: AnimatedSize(
            duration: Duration(milliseconds: 200),
            child: Column(
              children: [
                if (mode.isSignup())
                  TextField(
                    key: ValueKey('username'),
                    decoration: InputDecoration(
                      hintText: TextFieldConstants.username,
                    ),
                    onChanged: (value) {
                      setState(() => username = value);
                    },
                  ),
                TextField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    hintText: TextFieldConstants.email,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() => email = value);
                  },
                ),
                TextField(
                  key: ValueKey('password'),
                  decoration: InputDecoration(
                    hintText: TextFieldConstants.password,
                  ),
                  obscureText: true,
                  onChanged: (value) {
                    setState(() => password = value);
                  },
                ),
              ],
            ),
          ),
        ),
        TextButton(
          child: Text(mode.isLogin()
              ? ButtonConstants.switchToSignupMode
              : ButtonConstants.switchToLoginMode),
          onPressed: () {
            setState(() => mode = mode.switchMode());
          },
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 4.w),
          child: ElevatedButton(
            child: Text(mode.isLogin()
                ? ButtonConstants.login
                : ButtonConstants.signup),
            onPressed: () async {
              if (mode.isLogin()) {
                authUserBloc.add(
                  LoginUserStartedEvent(LoginUser(email, password)),
                );
              } else {
                authUserBloc.add(
                  SingUpUserStartedEvent(
                    SingUpUser(username, email, password),
                  ),
                );
              }
            },
          ),
        )
      ],
    );
  }
}
