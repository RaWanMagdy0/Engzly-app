import 'package:engzly/features/history/data/models/history_response_model.dart';

sealed class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistorySuccess extends HistoryState {
  final List<HistoryResponseModel> history;
  HistorySuccess(this.history);
}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
