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
import '../../features/auth/data/repo/login/google_repo.dart' as _i832;
import '../../features/auth/data/repo/login/login_repo.dart' as _i1003;
import '../../features/auth/data/repo/register/confirm_email_repo.dart'
    as _i834;
import '../../features/auth/data/repo/register/register_repo.dart' as _i109;
import '../../features/auth/logic/forget_password/forget_pass_cubit/cubit.dart'
    as _i13;
import '../../features/auth/logic/forget_password/reset_pass_cubit/cubit.dart'
    as _i1003;
import '../../features/auth/logic/forget_password/verify_email/cubit.dart'
    as _i854;
import '../../features/auth/logic/login_cubit/google.dart/google_cubit.dart'
    as _i282;
import '../../features/auth/logic/login_cubit/login/cubit.dart' as _i173;
import '../../features/auth/logic/register_cubit/cubit.dart' as _i690;
import '../../features/auth/ui/login/google_login/google_auth_service.dart'
    as _i873;
import '../../features/history/data/history_api/history_api_manager.dart'
    as _i50;
import '../../features/history/data/repo/history_repo.dart' as _i625;
import '../../features/history/logic/cubit.dart' as _i61;
import '../../features/home/data/home_api/home_api_manger.dart' as _i224;
import '../../features/home/data/repo/home_repo.dart' as _i429;
import '../../features/home/logic/cubit.dart' as _i563;
import '../../features/offers/ui/logic/offers_cubit.dart' as _i1059;
import '../../features/profile/data/profile_api/profile_api_manager.dart'
    as _i113;
import '../../features/profile/data/repo/change_password_repo.dart' as _i602;
import '../../features/profile/data/repo/get_locations_repo.dart' as _i832;
import '../../features/profile/data/repo/get_user_data_repo.dart' as _i374;
import '../../features/profile/data/repo/location_repo.dart' as _i807;
import '../../features/profile/data/repo/update_user_data_repo.dart' as _i89;
import '../../features/profile/logic/cubit.dart' as _i773;
import '../../features/services/cleaning/data/api_manager/cleaning_api_manager.dart'
    as _i502;
import '../../features/services/cleaning/data/repo/cleaning_repo.dart' as _i783;
import '../../features/services/cleaning/logic/cleaning_cubit.dart' as _i672;
import '../../features/services/house_shifting/data/api_manager/house_shifting_api.dart'
    as _i795;
import '../../features/services/house_shifting/data/repo/house_shifting_repo.dart'
    as _i650;
import '../../features/services/house_shifting/logic/booking_cubit.dart'
    as _i37;
import '../../features/services/house_shifting/logic/cubit.dart' as _i332;
import '../../features/services/painting/data/api_manager/painting_api_manager.dart'
    as _i357;
import '../../features/services/painting/data/repo/painting_repo.dart'
    as _i1025;
import '../../features/services/painting/logic/painting_cubit.dart' as _i596;
import '../../features/services/vehicle/data/api_manager/vehicle_api_manager.dart'
    as _i555;
import '../../features/services/vehicle/data/repo/vehicle_repo.dart' as _i791;
import '../../features/services/vehicle/logic/vehicle_cubit.dart' as _i694;
import '../../notification/notification_cubit.dart' as _i426;
import '../helper/functions/providers/app_provider.dart' as _i1040;
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
    gh.factory<_i873.AuthService>(() => _i873.AuthService());
    gh.singleton<_i1040.AppProvider>(() => _i1040.AppProvider());
    gh.lazySingleton<_i426.NotificationCubit>(() => _i426.NotificationCubit());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio(gh<_i777.DioFactory>()));
    gh.lazySingleton<_i1060.AuthApiManager>(
        () => _i1060.AuthApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i50.HistoryApiManager>(
        () => _i50.HistoryApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i224.HomeApiManager>(
        () => _i224.HomeApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i113.ProfileApiManager>(
        () => _i113.ProfileApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i502.CleaningApiManager>(
        () => _i502.CleaningApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i795.HouseShiftingApiManager>(
        () => _i795.HouseShiftingApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i357.PaintingApiManager>(
        () => _i357.PaintingApiManager(gh<_i361.Dio>()));
    gh.lazySingleton<_i555.VehicleApiManager>(
        () => _i555.VehicleApiManager(gh<_i361.Dio>()));
    gh.factory<_i896.ForgetPasswordRepo>(
        () => _i896.ForgetPasswordRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i688.ResetPasswordRepo>(
        () => _i688.ResetPasswordRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i78.VerifyEmailRepo>(
        () => _i78.VerifyEmailRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i832.GoogleLoginRepo>(
        () => _i832.GoogleLoginRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i1003.LoginRepo>(
        () => _i1003.LoginRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i834.ConfirmEmailRepo>(
        () => _i834.ConfirmEmailRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i109.RegisterRepo>(
        () => _i109.RegisterRepo(gh<_i1060.AuthApiManager>()));
    gh.factory<_i1003.ResetPasswordCubit>(
        () => _i1003.ResetPasswordCubit(gh<_i688.ResetPasswordRepo>()));
    gh.factory<_i791.VehicleRepo>(
        () => _i791.VehicleRepo(gh<_i555.VehicleApiManager>()));
    gh.factory<_i429.HomeRepo>(
        () => _i429.HomeRepo(gh<_i224.HomeApiManager>()));
    gh.factory<_i625.HistoryRepository>(
        () => _i625.HistoryRepository(gh<_i50.HistoryApiManager>()));
    gh.factory<_i61.HistoryCubit>(
        () => _i61.HistoryCubit(gh<_i625.HistoryRepository>()));
    gh.factory<_i650.HouseShiftingRepo>(
        () => _i650.HouseShiftingRepo(gh<_i795.HouseShiftingApiManager>()));
    gh.factory<_i690.RegisterCubit>(() => _i690.RegisterCubit(
          gh<_i109.RegisterRepo>(),
          gh<_i834.ConfirmEmailRepo>(),
        ));
    gh.factory<_i563.HomeCubit>(() => _i563.HomeCubit(gh<_i429.HomeRepo>()));
    gh.factory<_i1059.OffersCubit>(
        () => _i1059.OffersCubit(gh<_i429.HomeRepo>()));
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
    gh.factory<_i783.CleaningRepo>(
        () => _i783.CleaningRepo(gh<_i502.CleaningApiManager>()));
    gh.factory<_i1025.PaintingRepo>(
        () => _i1025.PaintingRepo(gh<_i357.PaintingApiManager>()));
    gh.factory<_i332.HouseShiftingCubit>(() => _i332.HouseShiftingCubit(
          gh<_i650.HouseShiftingRepo>(),
          gh<_i832.GetLocationsRepo>(),
        ));
    gh.factory<_i173.LoginCubit>(
        () => _i173.LoginCubit(gh<_i1003.LoginRepo>()));
    gh.factory<_i37.HouseShiftingBookingCubit>(
        () => _i37.HouseShiftingBookingCubit(gh<_i650.HouseShiftingRepo>()));
    gh.factory<_i282.GoogleLoginCubit>(() => _i282.GoogleLoginCubit(
          gh<_i873.AuthService>(),
          gh<_i832.GoogleLoginRepo>(),
        ));
    gh.factory<_i13.ForgetPasswordCubit>(
        () => _i13.ForgetPasswordCubit(gh<_i896.ForgetPasswordRepo>()));
    gh.factory<_i773.ProfileCubit>(() => _i773.ProfileCubit(
          gh<_i602.ChangePasswordRepo>(),
          gh<_i374.GetUserDataRepo>(),
          gh<_i89.UpdateUserDataRepo>(),
          gh<_i807.LocationRepo>(),
          gh<_i832.GetLocationsRepo>(),
        ));
    gh.factory<_i694.VehicleCubit>(() => _i694.VehicleCubit(
          gh<_i650.HouseShiftingRepo>(),
          gh<_i791.VehicleRepo>(),
          gh<_i832.GetLocationsRepo>(),
        ));
    gh.factory<_i672.CleaningCubit>(
        () => _i672.CleaningCubit(gh<_i783.CleaningRepo>()));
    gh.factory<_i596.PaintingCubit>(() => _i596.PaintingCubit(
          gh<_i650.HouseShiftingRepo>(),
          gh<_i1025.PaintingRepo>(),
          gh<_i832.GetLocationsRepo>(),
        ));
    return this;
  }
}

class _$DioModule extends _i713.DioModule {}
