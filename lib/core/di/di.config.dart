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
import '../../features/auth/data/repo/confirm_email_repo.dart' as _i133;
import '../../features/auth/data/repo/login_repo.dart' as _i869;
import '../../features/auth/data/repo/register_repo.dart' as _i871;
import '../../features/auth/logic/login_cubit/cubit.dart' as _i302;
import '../../features/auth/logic/register_cubit/cubit.dart' as _i690;
import '../helper/functions/providers/app_provider.dart' as _i1040;
import '../helper/local/app_provider.dart' as _i44;
import '../networking/api/dio/dio_factory.dart' as _i777;
import '../networking/api/dio/dio_module.dart' as _i713;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dioModule = _$DioModule();
    gh.factory<_i777.DioFactory>(() => _i777.DioFactory());
    gh.singleton<_i1040.AppProvider>(() => _i1040.AppProvider());
    gh.singleton<_i44.AppProvider>(() => _i44.AppProvider());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio(gh<_i777.DioFactory>()));
    gh.lazySingleton<_i1060.AuthApiManager>(
        () => _i1060.AuthApiManager(gh<_i361.Dio>()));
    gh.factory<_i869.LoginRepo>(
        () => _i869.LoginRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i871.RegisterRepo>(
        () => _i871.RegisterRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i133.ConfirmEmailRepo>(
        () => _i133.ConfirmEmailRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i302.LoginCubit>(() => _i302.LoginCubit(gh<_i869.LoginRepo>()));
    gh.factory<_i690.RegisterCubit>(() => _i690.RegisterCubit(
          gh<_i871.RegisterRepo>(),
          gh<_i133.ConfirmEmailRepo>(),
        ));
    return this;
  }
}

class _$DioModule extends _i713.DioModule {}
