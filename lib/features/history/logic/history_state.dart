import '../../scan/data/models/waste_result_model.dart';

sealed class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<WasteResultModel> scans;
  HistoryLoaded(this.scans);
}

class HistoryEmpty extends HistoryState {}

class HistoryError extends HistoryState {
  final String message;
  HistoryError(this.message);
}
