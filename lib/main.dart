import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/general/theme_cubit.dart';
import 'application/router/router_delegate.dart';
import 'application/router/route_information_parser.dart';
import 'infrastructure/injector/injector.dart';
import 'presentation/theme/my_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, MyTheme>(
        builder: (BuildContext context, state) {
          return  MaterialApp.router(
            title: 'Flutter Theme',
            theme: state.theme,
            routerDelegate: PetProjectDelegate(),
            routeInformationParser: PetProjectRouteInformationParser(),
            backButtonDispatcher: RootBackButtonDispatcher(),
          );
        },
      ),
    );
  }
}
