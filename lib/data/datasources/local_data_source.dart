import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  bool get isDarkMode;

  Future<void> setThemeMode(bool isDark);
}

const IS_DARK = 'IS_DARK';

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  bool get isDarkMode {
    final isDark = sharedPreferences.getBool(IS_DARK);
    return isDark ?? false;
  }

  @override
  Future<void> setThemeMode(bool isDark) async {
    await sharedPreferences.setBool(IS_DARK, isDark);
  }
}