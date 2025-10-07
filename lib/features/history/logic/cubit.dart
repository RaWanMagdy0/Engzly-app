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
  int currentPage = 1;
  bool hasMoreData = true;
  bool isLoadingMore = false;

  Future<void> getHistory({
    bool loadMore = false,
    int pageSize = 2,
    String sortDirection = "desc",
  }) async {
    if (loadMore) {
      if (!hasMoreData || isLoadingMore) return;
      isLoadingMore = true;
      currentPage++;
    } else {
      emit(HistoryLoading());
      currentPage = 1;
      historyResponse.clear();
      hasMoreData = true;
    }

    final result = await _repository.getUserHistory(
      pageNumber: currentPage,
      pageSize: pageSize,
      sortDirection: sortDirection,
    );

    if (result is Success<List<HistoryResponseModel>>) {
      final newItems = result.data ?? [];

      if (newItems.isEmpty || newItems.length < pageSize) {
        hasMoreData = false;
      }

      historyResponse.addAll(newItems);
      emit(HistorySuccess(List.from(historyResponse)));
    } else if (result is Fail) {
      if (loadMore) {
        currentPage--;
      }
      final failResult = result as Fail;
      final errorMessage = getErrorMessageFromException(failResult.exception);
      emit(HistoryError(errorMessage));
    }

    isLoadingMore = false;
  }

  void loadMoreHistory() {
    getHistory(loadMore: true);
  }
}
