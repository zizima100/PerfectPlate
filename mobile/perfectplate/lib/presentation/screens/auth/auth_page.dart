import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/utils/user_utils.dart';
import 'package:perfectplate/data/models/auth/auth_models.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/presentation/utils/router/route_helper.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:perfectplate/presentation/screens/auth/widgets/text_fields.dart';
import 'package:perfectplate/presentation/utils/widgets/snackbar_utils.dart';
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
          SnackBarUtils.auth(context)
              .showSnackBarError(ErrorMessagesConstants.mandatoryFieldsEmpty);
        }
        if (state is UserNotFound) {
          SnackBarUtils.auth(context)
              .showSnackBarError(ErrorMessagesConstants.userNotFound);
        }
        if (state is EmailInvalid) {
          SnackBarUtils.auth(context)
              .showSnackBarError(ErrorMessagesConstants.emailAlreadyExists);
        }
        if (state is AuthSuccessful) {
          RouteHelper.removeAllAndPushTo(context, Routes.home);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green[50],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.all(3.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
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
            ],
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
  late String name;
  late SingUpUser signUpUser;
  late AuthMode mode;
  late AuthUserBloc authUserBloc;
  late UserType userType;
  late SexType sexType;

  @override
  void initState() {
    mode = AuthMode(Mode.login);
    signUpUser = SingUpUser();
    email = '';
    password = '';
    name = '';
    userType = UserType.defaultUser;
    sexType = SexType.masculine;
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
                    key: ValueKey('name'),
                    decoration: InputDecoration(
                      hintText: TextFieldConstants.name,
                    ),
                    onChanged: (value) {
                      setState(() => name = value.trim());
                    },
                  ),
                TextField(
                  key: ValueKey('email'),
                  decoration: InputDecoration(
                    hintText: TextFieldConstants.email,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    setState(() => email = value.trim());
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
                if (mode.isSignup())
                  Column(
                    children: [
                      Row(
                        children: [
                          NumberTextField(
                            textFieldKey: 'age',
                            hintText: TextFieldConstants.age,
                            maxLenght: 3,
                            onChanged: (value) {
                              setState(() => signUpUser.age = value.trim());
                            },
                          ),
                          SizedBox(width: 5.h),
                          NumberTextField(
                            textFieldKey: 'weight',
                            hintText: TextFieldConstants.weight,
                            maxLenght: 5,
                            onChanged: (value) {
                              setState(() => signUpUser.weight = value.trim());
                            },
                          ),
                          SizedBox(width: 5.h),
                          NumberTextField(
                            textFieldKey: 'height',
                            hintText: TextFieldConstants.height,
                            maxLenght: 5,
                            onChanged: (value) {
                              setState(() => signUpUser.height = value.trim());
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DropdownButton<UserType>(
                            value: userType,
                            onChanged: (value) {
                              setState(() {
                                userType = value ?? UserType.defaultUser;
                              });
                            },
                            items: UserType.values.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child:
                                    Text(UserUtils.parseTypeEnumToTitle(value)),
                              );
                            }).toList(),
                          ),
                          DropdownButton<SexType>(
                            value: sexType,
                            onChanged: (value) {
                              setState(() {
                                sexType = value ?? SexType.masculine;
                              });
                            },
                            items: SexType.values.map((value) {
                              return DropdownMenuItem(
                                value: value,
                                child:
                                    Text(UserUtils.parseSexEnumToTitle(value)),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
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
            child: BlocBuilder<AuthUserBloc, AuthUserState>(
              builder: (context, state) {
                if (state is AuthLoading) {
                  return SizedBox(
                    height: 2.5.h,
                    width: 2.5.h,
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  );
                }
                return Text(mode.isLogin()
                    ? ButtonConstants.login
                    : ButtonConstants.signup);
              },
            ),
            onPressed: () async {
              if (mode.isLogin()) {
                authUserBloc.add(
                  LoginUserStartedEvent(LoginUser(email, password)),
                );
              } else {
                signUpUser.email = email;
                signUpUser.password = password;
                signUpUser.name = name;
                signUpUser.userType = UserUtils.parseTypeEnumToField(userType);
                signUpUser.sex = UserUtils.parseSexEnumToTitle(sexType);
                print('signUpUser = $signUpUser');
                authUserBloc.add(SingUpUserStartedEvent(signUpUser));
              }
            },
          ),
        )
      ],
    );
  }
}
