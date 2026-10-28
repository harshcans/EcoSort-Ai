import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/model/scan_history_model.dart';
import '../data/repo/scan_history_repository.dart';
import 'history_state.dart';

class HistoryCubit extends Cubit<HistoryState> {
  final ScanHistoryRepository repository;

  HistoryCubit({required this.repository}) : super(HistoryInitial());

  Future<void> loadHistory() async {
    emit(HistoryLoading());
    try {
      final scans = await repository.getScans();
      if (scans.isEmpty) {
        emit(HistoryEmpty());
      } else {
        emit(HistoryLoaded(scans));
      }
    } catch (e) {
      emit(HistoryError('Failed to load history: ${e.toString()}'));
    }
  }

  String _safeGetId(ScanHistoryModel item) {
    try {
      final json = item.toJson();
      return (json['_id'] ?? json['id'] ?? json['scanId'] ?? '').toString();
    } catch (_) {
      return '';
    }
  }

  Future<void> deleteScan(String targetId) async {
    final currentState = state;
    if (currentState is HistoryLoaded) {
      final List<ScanHistoryModel> originalList = List.from(currentState.scans);

      final updatedList = currentState.scans.where((item) {
        final itemId = _safeGetId(item);
        return itemId.isNotEmpty && itemId != targetId;
      }).toList();

      if (updatedList.isEmpty) {
        emit(HistoryEmpty());
      } else {
        emit(HistoryLoaded(updatedList));
      }

      try {
        final success = await repository.deleteScan(targetId);
        if (!success) {
          emit(HistoryLoaded(originalList));
        }
      } catch (e) {
        emit(HistoryLoaded(originalList));
      }
    }
  }
}