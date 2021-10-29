import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/data/models/plates/plates.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/router/routes.dart';
import 'package:perfectplate/presentation/screens/home/widgets/app_drawer.dart';
import 'package:perfectplate/presentation/screens/home/widgets/plate_insertion.dart';
import 'package:perfectplate/presentation/utils/router/route_helper.dart';
import 'package:perfectplate/presentation/utils/widgets/snackbar_utils.dart';

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
        child: FutureBuilder<List<Ingredient>>(
          future: BlocProvider.of<PlatesBloc>(context).retrieveAllIngredients(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Ocorreu um erro :('));
            }
            return PlateInsertionWidget(ingredients: snapshot.data!);
          },
        ),
      ),
    );
  }
}
