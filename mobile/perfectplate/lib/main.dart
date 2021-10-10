import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:perfectplate/logic/bloc/auth/auth_bloc.dart';
import 'package:perfectplate/presentation/router/generated_routes.dart';
import 'package:perfectplate/presentation/router/routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const PerfectPlateApp());
}

class PerfectPlateApp extends StatelessWidget {
  const PerfectPlateApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(),
          ),
        ],
        child: MaterialApp(
          title: 'Perfect Plate',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          onGenerateRoute: PerfectPlateRouter.generateRoute,
          initialRoute: Routes.auth,
        ),
      );
    });
  }
}
