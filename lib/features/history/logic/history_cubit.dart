import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/history_local_service.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final HistoryLocalService historyService;

  HistoryCubit({required this.historyService}) : super(HistoryInitial());

  // 1. Storage se saare scans load karna
  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      final scans = await historyService.getScans();
      if (scans.isEmpty) {
        emit(HistoryEmpty());
      } else {
        emit(HistoryLoaded(scans));
      }
    } catch (e) {
      emit(HistoryError('Failed to load history: ${e.toString()}'));
    }
  }

  // 2. Poori history clear karna
  Future<void> clearHistory() async {
    emit(HistoryLoading());
    try {
      await historyService.clearHistory();
      emit(HistoryEmpty());
    } catch (e) {
      emit(HistoryError('Failed to clear history: ${e.toString()}'));
    }
  }
}
