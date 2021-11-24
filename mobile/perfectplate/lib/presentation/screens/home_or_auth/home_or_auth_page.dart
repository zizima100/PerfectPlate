import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/screens/auth/auth_page.dart';
import 'package:perfectplate/presentation/screens/home/plates_home_screen.dart';

class HomeOrAuth extends StatelessWidget {
  const HomeOrAuth({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: BlocProvider.of<AuthUserBloc>(context).retrieveUserIdCache(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Material(child: Center(child: Text('Ocorreu um erro! :(')));
        }
        int? userId = snapshot.data;
        if(userId == null) {
          return AuthPage();
        } else {
          BlocProvider.of<PlatesBloc>(context).add(UserAuthenticated(userId: userId));
          return PlatesMainScreen();
        }
      },
    );
  }
}
