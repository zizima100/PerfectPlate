import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Bem-vindo!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            key: const ValueKey('leave_app_key'),
            leading: const Icon(Icons.exit_to_app),
            title: const Text(ButtonConstants.leave_app),
            onTap: () => BlocProvider.of<AuthUserBloc>(context).add(LogoutStartedEvent()),
          ),
        ],
      ),
    );
  }
}
