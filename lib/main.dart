import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'injection_container.dart' as di;
import 'presentation/pages/my_home_page.dart';
import 'presentation/theme/my_theme.dart';
import 'application/general/theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit())
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
