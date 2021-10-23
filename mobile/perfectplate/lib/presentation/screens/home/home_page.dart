import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/logic/bloc/meals_bloc/meals_bloc.dart';
import 'package:perfectplate/presentation/router/routes.dart';
import 'package:perfectplate/presentation/screens/home/widgets/app_drawer.dart';
import 'package:perfectplate/presentation/utils/router/route_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: Text('Perfect Plate'),
      ),
      body: BlocListener<AuthUserBloc, AuthUserState>(
        listenWhen: (previous, current) => previous != current,
        listener: (_, state) {
          if (state is UserLogout) {
            RouteHelper.removeAllAndPushTo(context, Routes.auth);
          }
        },
        child: Center(
          child: Column(
            children: [
              Text('user id = ${BlocProvider.of<MealsBloc>(context).userId.toString()}'),
              ElevatedButton(
                child: Text('Insira um prato'),
                onPressed: () {
                  BlocProvider.of<MealsBloc>(context).add(MealsInsertionStarted());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
