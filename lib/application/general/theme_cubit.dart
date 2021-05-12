import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:pet_project/data/datasources/local_data_source.dart';
import 'package:pet_project/presentation/theme/my_theme.dart';

@injectable
class ThemeCubit extends Cubit<MyTheme> {
  final LocalDataSource _localDataSource;

  @factoryMethod
  ThemeCubit(this._localDataSource)
      : super(_localDataSource.isDarkMode ? MyTheme.dark() : MyTheme.light());

  Future<void> setTheme() async {
    state.isDark ? emit(MyTheme.light()) : emit(MyTheme.dark());

    await _localDataSource.setThemeMode(state.isDark);
  }
}
