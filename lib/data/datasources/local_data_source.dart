import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  bool get isDarkMode;

  Future<void> setThemeMode(bool isDark);
}

const IS_DARK = 'IS_DARK';

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences _sharedPreferences;

  LocalDataSourceImpl(this._sharedPreferences);

  @override
  bool get isDarkMode {
    final isDark =_sharedPreferences.getBool(IS_DARK);
    return isDark ?? false;
  }

  @override
  Future<void> setThemeMode(bool isDark) async {
    await _sharedPreferences.setBool(IS_DARK, isDark);
  }
}