import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:perfectplate/data/models/plates/plates_list.dart';
import 'package:perfectplate/data/repositories/mock_plates_repository.dart';
import 'package:perfectplate/data/repositories/plates_repository_imp.dart';
import 'package:perfectplate/logic/bloc/auth_user/auth_user_bloc.dart';
import 'package:perfectplate/logic/bloc/plates_bloc/plates_bloc.dart';
import 'package:perfectplate/presentation/utils/router/generated_routes.dart';
import 'package:perfectplate/presentation/utils/router/routes.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const PerfectPlateApp());
  GetIt.I.registerSingleton<PlatesList>(PlatesList());
}

class PerfectPlateApp extends StatelessWidget {
  const PerfectPlateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthUserBloc(),
          ),
          BlocProvider(
            create: (context) => PlatesBloc(
              MockPlatesRepository(),
            ),
          )
        ],
        child: MaterialApp(
          title: 'Perfect Plate',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          onGenerateRoute: PerfectPlateRouter.generateRoute,
          initialRoute: Routes.homeOrAuth,
        ),
      );
    });
  }
}
