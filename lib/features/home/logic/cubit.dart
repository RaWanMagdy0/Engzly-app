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

  Future<void> loadHomeData() async {
    emit(HomeLoading());

    final offersResult = await _homeRepo.getOffers();
    final servicesResult = await _homeRepo.getservice();

    if (offersResult is Success<List<OffersResponseModel>> &&
        servicesResult is Success<List<ServiceResponseModel>>) {
      offersResponse = offersResult.data!;
      serviceResponse = servicesResult.data!;
      emit(HomeDataSuccess(offersResponse, serviceResponse));
    } else {
      emit(HomeError("Failed to load home data"));
    }
  }
}
