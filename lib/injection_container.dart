import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/local_data_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<LocalDataSource>(
        () => LocalDataSourceImpl(sharedPreferences: sl()),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}