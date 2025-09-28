import 'package:engzly/core/networking/api/api_result.dart';
import 'package:engzly/core/networking/base_view_model.dart';
import 'package:engzly/features/history/data/models/history_response_model.dart';
import 'package:engzly/features/history/data/repo/history_repo.dart';
import 'package:engzly/features/history/logic/state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HistoryCubit extends BaseViewModel<HistoryState> {
  final HistoryRepository _repository;

  HistoryCubit(this._repository) : super(HistoryInitial());

  List<HistoryResponseModel> historyResponse = [];

  Future<void> getHistory({
    int pageNumber = 1,
    int pageSize = 3,
    String sortDirection = "desc",
  }) async {
    emit(HistoryLoading());

    final result = await _repository.getUserHistory(
      pageNumber: pageNumber,
      pageSize: pageSize,
      sortDirection: sortDirection,
    );

    if (result is Success<List<HistoryResponseModel>>) {
      historyResponse = result.data ?? [];
      emit(HistorySuccess(historyResponse));
    } else if (result is Fail) {
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(HistoryError(errorMessage));
    }
  }
}
