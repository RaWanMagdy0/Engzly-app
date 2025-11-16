import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';
import 'package:engzly/features/home/data/models/service/service_response_model.dart';
import 'package:engzly/features/home/data/repo/home_repo.dart';
import 'package:engzly/features/home/logic/state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends BaseViewModel<HomeState> {
  final HomeRepo _homeRepo;

  HomeCubit(this._homeRepo) : super(HomeInitial());

  List<ServiceResponseModel> serviceResponse = [];
  List<OffersResponseModel> offersResponse = [];

  Future<void> loadOffers() async {
    emit(OffersLoading());

    final offersResult = await _homeRepo.getOffers();

    if (offersResult is Success<List<OffersResponseModel>>) {
      offersResponse = offersResult.data!;
      emit(HomeOffersSuccess(offersResponse));
    } else {
      emit(OffersError("Failed to load offers"));
    }
  }

  Future<void> loadServices() async {
    emit(ServiceLoading());

    final servicesResult = await _homeRepo.getservice();

    if (servicesResult is Success<List<ServiceResponseModel>>) {
      serviceResponse = servicesResult.data!;
      emit(HomeServicesSuccess(serviceResponse));
    } else {
      emit(ServiceError("Failed to load services"));
    }
  }
}
