import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() => $initGetIt(getIt);
// Future<void> init() async {
//   sl.registerLazySingleton<LocalDataSource>(
//         () => LocalDataSourceImpl(sharedPreferences: sl()),
//   );
//
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
// }