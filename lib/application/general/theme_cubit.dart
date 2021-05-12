import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'package:pet_project/data/datasources/local_data_source.dart';
import 'package:pet_project/presentation/theme/my_theme.dart';


class ThemeCubit extends Cubit<MyTheme> {
  static final LocalDataSource localDataSource = GetIt.I();
  ThemeCubit() : super(localDataSource.isDarkMode ? MyTheme.dark() : MyTheme.light());

  Future<void> setTheme() async {
    state.isDark ? emit(MyTheme.light()) : emit(MyTheme.dark());

    await localDataSource.setThemeMode(state.isDark);
  }
}
