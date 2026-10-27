import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/image_picker_service.dart';
import '../../history/data/history_local_service.dart';
import '../data/repositories/scan_repository.dart';
import 'scan_state.dart';

class ScanCubit extends Cubit<ScanState> {
  final ScanRepository _scanRepository;
  final ImagePickerService _pickerService;
  final HistoryLocalService _historyService;

  ScanCubit({
    required this._scanRepository,
    required this._pickerService,
    required this._historyService,
  }) : super(const ScanInitial());

  Future<void> captureAndClassify(ImageSource source) async {
    try {
      final File? image = await _pickerService.pickImage(source);

      if (isClosed || image == null) return;

      emit(ScanImagePicked(image));
      emit(const ScanLoading());

      final result = await _scanRepository.classifyImage(image);

      if (isClosed) return;

      await _historyService.saveScan(result);

      if (isClosed) return;

      emit(ScanSuccess(result));
    } catch (e) {
      if (isClosed) return;

      emit(ScanError('Classification failed: ${e.toString()}'));
    }
  }

  void reset() {
    if (isClosed) return;

    emit(const ScanInitial());
  }
}
