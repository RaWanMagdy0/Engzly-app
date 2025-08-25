// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/data/auth_api/auth_api_manager.dart' as _i1060;
import '../../features/auth/data/repo/login_repo.dart' as _i869;
import '../../features/auth/logic/cubit.dart' as _i476;
import '../networking/api/dio/dio_factory.dart' as _i777;
import '../networking/api/dio/dio_module.dart' as _i713;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.factory<_i777.DioFactory>(() => _i777.DioFactory());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio(gh<_i777.DioFactory>()));
    gh.lazySingleton<_i1060.AuthApiManager>(
      () => _i1060.AuthApiManager(gh<_i361.Dio>()),
    );
    gh.factory<_i869.LoginRepo>(
      () => _i869.LoginRepo(gh<_i1060.AuthApiManager>()),
    );
    gh.factory<_i476.LoginCubit>(() => _i476.LoginCubit(gh<_i869.LoginRepo>()));
    return this;
  }
}

class _$DioModule extends _i713.DioModule {}
