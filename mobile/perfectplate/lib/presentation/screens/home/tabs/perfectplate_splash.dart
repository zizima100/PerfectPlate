import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/core/constants/strings.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/screens/home/plates_home_screen.dart';

class PerfectPlateSplash extends StatelessWidget {
  const PerfectPlateSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.of<PlatesBloc>(context).mapAllUserPlates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            color: Colors.white,
            child: Image.asset(
              ImageConstants.logoImage,
              fit: BoxFit.scaleDown,
            ),
          );
        }
        return PlatesMainScreen();
      },
    );
  }
}
