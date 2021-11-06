import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/screens/auth/auth_page.dart';
import 'package:perfectplate/presentation/screens/home/plates_home_page.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:perfectplate/presentation/screens/home/widgets/plate_insertion.dart';
import 'package:perfectplate/presentation/utils/router/route_helper.dart';

class HomeOrAuth extends StatelessWidget {
  const HomeOrAuth({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: BlocProvider.of<AuthUserBloc>(context).isUserLogged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Ocorreu um erro :('));
        }
        bool? isUserLogged = snapshot.data;
        if(isUserLogged == null || isUserLogged == false) {
          return AuthPage();
        } else {
          return PlatesHomePage();
        }
      },
    );
  }
}
