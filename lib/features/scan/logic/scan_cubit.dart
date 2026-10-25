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
  }) : super(ScanInitial());

  Future<void> captureAndClassify(ImageSource source) async {
    try {
      final File? image = await _pickerService.pickImage(source);
      if (image == null) return; // User cancelled picker

      emit(ScanImagePicked(image));
      emit(ScanLoading());

      final result = await _scanRepository.classifyImage(image);

      // Offline history me automatically save karna
      await _historyService.saveScan(result);

      emit(ScanSuccess(result));
    } catch (e) {
      emit(ScanError("Classification failed: ${e.toString()}"));
    }
  }

  void reset() {
    emit(ScanInitial());
  }
}
