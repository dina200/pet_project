import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'infrastructure/injector/injector.dart';
import 'presentation/pages/my_home_page.dart';
import 'presentation/theme/my_theme.dart';
import 'application/general/theme_cubit.dart';

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
          return  MaterialApp(
            title: 'Flutter Theme',
            theme: state.theme,
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}
