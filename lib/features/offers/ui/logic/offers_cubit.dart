import 'package:engzly/features/home/data/repo/home_repo.dart';
import 'package:engzly/features/offers/ui/logic/offers_states.dart';
import 'package:injectable/injectable.dart';

import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/home/data/models/offers/offers_response_model.dart';

@injectable
class OffersCubit extends BaseViewModel<OffersState> {
  final HomeRepo _homeRepo;

  OffersCubit(this._homeRepo) : super(OffersInitial());

  List<OffersResponseModel> offersList = [];

  Future<void> getOffers() async {
    emit(OffersLoading());

    final result = await _homeRepo.getOffers();

    if (isClosed) return;

    if (result is Success<List<OffersResponseModel>>) {
      offersList = result.data ?? [];
      emit(OffersSuccess(offersList));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(OffersError(errorMessage));
    }
  }
}
