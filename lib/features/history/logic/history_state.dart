import '../data/model/scan_history_model.dart';

abstract class HistoryState {}

class HistoryInitial extends HistoryState {}

class HistoryLoading extends HistoryState {}

class HistoryEmpty extends HistoryState {}

class HistoryLoaded extends HistoryState {
  final List<ScanHistoryModel> scans;

  HistoryLoaded(this.scans);
}

class HistoryError extends HistoryState {
  final String message;

  HistoryError(this.message);
}
