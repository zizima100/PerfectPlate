import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/logic/bloc/auth/auth_bloc.dart';
import 'package:perfectplate/presentation/router/routes.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:sizer/sizer.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
    return Container(
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
    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
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
                          authBloc
                              .add(AuthUsernameChangedEvent(username: value));
                        },
                      ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: TextFieldConstants.email,
                      ),
                      onChanged: (value) {
                        authBloc.add(AuthEmailChangedEvent(email: value));
                      },
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: TextFieldConstants.password,
                      ),
                      onChanged: (value) {
                        authBloc.add(AuthPasswordChangedEvent(password: value));
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
                authBloc.add(AuthModeSwitchedEvent());
              },
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 4.w),
              child: ElevatedButton(
                child: Text(state.mode.isLogin()
                    ? ButtonConstants.login
                    : ButtonConstants.singup),
                onPressed: () async {
                  await authBloc.authenticate();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.home,
                    (Route<dynamic> route) => false,
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
