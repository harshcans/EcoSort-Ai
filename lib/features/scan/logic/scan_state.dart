import 'dart:io';
import '../data/models/waste_result_model.dart';

sealed class ScanState {
  const ScanState();
}

class ScanInitial extends ScanState {
  const ScanInitial();
}

class ScanImagePicked extends ScanState {
  final File image;
  const ScanImagePicked(this.image);
}

class ScanLoading extends ScanState {
  const ScanLoading();
}

class ScanSuccess extends ScanState {
  final WasteResultModel result;
  const ScanSuccess(this.result);
}

class ScanError extends ScanState {
  final String message;
  const ScanError(this.message);
}