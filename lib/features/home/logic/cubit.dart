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
      final allGroups = offersResult.data ?? [];

      final filteredGroups = allGroups.map((group) {
        final activeOffers = group.offers.where((o) => o.isActive).toList();

        return OffersResponseModel(
          type: group.type,
          offers: activeOffers,
        );
      }).toList();

      offersResponse =
          filteredGroups.where((group) => group.offers.isNotEmpty).toList();

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
