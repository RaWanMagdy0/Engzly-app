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
import '../../features/auth/data/repo/forget_password/forget_password_repo.dart'
    as _i896;
import '../../features/auth/data/repo/forget_password/reset_password_repo.dart'
    as _i688;
import '../../features/auth/data/repo/forget_password/verify_email_repo.dart'
    as _i78;
import '../../features/auth/data/repo/login_repo.dart' as _i869;
import '../../features/auth/data/repo/register/confirm_email_repo.dart'
    as _i834;
import '../../features/auth/data/repo/register/register_repo.dart' as _i109;
import '../../features/auth/logic/forget_password/forget_pass_cubit/cubit.dart'
    as _i13;
import '../../features/auth/logic/forget_password/reset_pass_cubit/cubit.dart'
    as _i1003;
import '../../features/auth/logic/forget_password/verify_email/cubit.dart'
    as _i854;
import '../../features/auth/logic/login_cubit/cubit.dart' as _i302;
import '../../features/auth/logic/register_cubit/cubit.dart' as _i690;
import '../../features/history/data/history_api/history_api_manager.dart'
    as _i50;
import '../../features/history/data/repo/history_repo.dart' as _i625;
import '../../features/history/logic/cubit.dart' as _i61;
import '../../features/home/data/home_api/home_api_manger.dart' as _i224;
import '../../features/home/data/repo/home_repo.dart' as _i429;
import '../../features/home/logic/cubit.dart' as _i563;
import '../../features/profile/data/profile_api/profile_api_manager.dart'
    as _i113;
import '../../features/profile/data/repo/change_password_repo.dart' as _i602;
import '../../features/profile/data/repo/get_locations_repo.dart' as _i832;
import '../../features/profile/data/repo/get_user_data_repo.dart' as _i374;
import '../../features/profile/data/repo/location_repo.dart' as _i807;
import '../../features/profile/data/repo/update_user_data_repo.dart' as _i89;
import '../../features/profile/logic/cubit.dart' as _i773;
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
    gh.lazySingleton<_i224.HomeApiManager>(
        () => _i224.HomeApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i113.ProfileApiManager>(
        () => _i113.ProfileApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i50.HistoryApiManager>(
        () => _i50.HistoryApiManager(gh<_i361.Dio>()));
    gh.factory<_i896.ForgetPasswordRepo>(
        () => _i896.ForgetPasswordRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i688.ResetPasswordRepo>(
        () => _i688.ResetPasswordRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i78.VerifyEmailRepo>(
        () => _i78.VerifyEmailRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i869.LoginRepo>(
        () => _i869.LoginRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i834.ConfirmEmailRepo>(
        () => _i834.ConfirmEmailRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i109.RegisterRepo>(
        () => _i109.RegisterRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i302.LoginCubit>(() => _i302.LoginCubit(gh<_i869.LoginRepo>()));
    gh.factory<_i1003.ResetPasswordCubit>(
        () => _i1003.ResetPasswordCubit(gh<_i688.ResetPasswordRepo>()));
    gh.factory<_i429.HomeRepo>(
        () => _i429.HomeRepo(gh<_i224.HomeApiManager>()));
    gh.factory<_i625.HistoryRepository>(
        () => _i625.HistoryRepository(gh<_i50.HistoryApiManager>()));
    gh.factory<_i61.HistoryCubit>(
        () => _i61.HistoryCubit(gh<_i625.HistoryRepository>()));
    gh.factory<_i690.RegisterCubit>(() => _i690.RegisterCubit(
          gh<_i109.RegisterRepo>(),
          gh<_i834.ConfirmEmailRepo>(),
        ));
    gh.factory<_i563.HomeCubit>(() => _i563.HomeCubit(gh<_i429.HomeRepo>()));
    gh.factory<_i602.ChangePasswordRepo>(
        () => _i602.ChangePasswordRepo(gh<_i113.ProfileApiManager>()));
    gh.factory<_i832.GetLocationsRepo>(
        () => _i832.GetLocationsRepo(gh<_i113.ProfileApiManager>()));
    gh.factory<_i374.GetUserDataRepo>(
        () => _i374.GetUserDataRepo(gh<_i113.ProfileApiManager>()));
    gh.factory<_i807.LocationRepo>(
        () => _i807.LocationRepo(gh<_i113.ProfileApiManager>()));
    gh.factory<_i89.UpdateUserDataRepo>(
        () => _i89.UpdateUserDataRepo(gh<_i113.ProfileApiManager>()));
    gh.factory<_i854.VerifyEmailCubit>(
        () => _i854.VerifyEmailCubit(gh<_i78.VerifyEmailRepo>()));
    gh.factory<_i13.ForgetPasswordCubit>(
        () => _i13.ForgetPasswordCubit(gh<_i896.ForgetPasswordRepo>()));
    gh.factory<_i773.ProfileCubit>(() => _i773.ProfileCubit(
          gh<_i602.ChangePasswordRepo>(),
          gh<_i374.GetUserDataRepo>(),
          gh<_i89.UpdateUserDataRepo>(),
          gh<_i807.LocationRepo>(),
          gh<_i832.GetLocationsRepo>(),
        ));
    return this;
  }
}

class _$DioModule extends _i713.DioModule {}
