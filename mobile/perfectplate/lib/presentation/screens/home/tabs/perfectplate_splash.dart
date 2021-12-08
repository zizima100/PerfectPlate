import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/screens/home/plates_home_screen.dart';
import 'package:perfectplate/presentation/screens/home/tabs/widgets/splash_image.dart';

class PerfectPlateInitMain extends StatelessWidget {
  const PerfectPlateInitMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: BlocProvider.of<PlatesBloc>(context).mapAllUserPlates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return PerfectPlateSplashImage();
        }
        return PlatesMainScreen();
      },
    );
  }
}
