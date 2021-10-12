import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/logic/bloc/auth_form/auth_form_bloc.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthUserBloc, AuthUserState>(
      listener: (context, state) {
        if (state is AuthMandatoryFieldsEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red.shade100,
              duration: Duration(milliseconds: 1500),
              content: Text(
                ErrorMessagesConstants.mandatoryFieldsEmpty,
                style: TextStyle(
                  color: Colors.red.shade900,
                ),
              ),
            ),
          );
        }
        if (state is AuthSuccessful) {
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
  @override
  Widget build(BuildContext context) {
    AuthFormBloc authFormBloc = BlocProvider.of<AuthFormBloc>(context);
    AuthUserBloc authUserBloc = BlocProvider.of(context);

    return BlocBuilder<AuthFormBloc, AuthFormState>(
      builder: (context, state) {
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 3.w),
              child: AnimatedSize(
                duration: Duration(milliseconds: 200),
                child: Column(
                  children: [
                    if (state.mode.isSignup())
                      TextField(
                        decoration: InputDecoration(
                          hintText: TextFieldConstants.username,
                        ),
                        onChanged: (value) {
                          authFormBloc
                              .add(AuthUsernameChangedEvent(username: value));
                        },
                      ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: TextFieldConstants.email,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) {
                        authFormBloc.add(AuthEmailChangedEvent(email: value));
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: TextFieldConstants.password,
                      ),
                      obscureText: true,
                      onChanged: (value) {
                        authFormBloc
                            .add(AuthPasswordChangedEvent(password: value));
                      },
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
              child: Text(state.mode.isLogin()
                  ? ButtonConstants.switchToSignupMode
                  : ButtonConstants.switchToLoginMode),
              onPressed: () {
                authFormBloc.add(AuthModeSwitchedEvent());
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4.w),
              child: ElevatedButton(
                child: Text(state.mode.isLogin()
                    ? ButtonConstants.login
                    : ButtonConstants.signup),
                onPressed: () async {
                  if (authFormBloc.state.mode.isLogin()) {
                    authUserBloc.add(
                      LoginUserStarted(LoginUser(state.email, state.password)),
                    );
                  } else {
                    authUserBloc.add(
                      SingUpUserStarted(
                        SingUpUser(state.username, state.email, state.password),
                      ),
                    );
                  }
                },
              ),
            )
          ],
        );
      },
    );
  }
}
