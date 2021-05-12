// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

import '../../application/general/theme_cubit.dart' as _i5;
import '../../data/datasources/local_data_source.dart' as _i4;
import '../register_module.dart' as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  await gh.factoryAsync<_i3.SharedPreferences>(() => registerModule.sharedPrefs,
      preResolve: true);
  gh.singleton<_i4.LocalDataSource>(
      _i4.LocalDataSourceImpl(get<_i3.SharedPreferences>()));
  gh.singleton<_i5.ThemeCubit>(_i5.ThemeCubit(get<_i4.LocalDataSource>()));
  return get;
}

class _$RegisterModule extends _i6.RegisterModule {}
