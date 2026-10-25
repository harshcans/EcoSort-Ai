import 'dart:io';
import '../models/waste_result_model.dart';

abstract class ScanRepository {
  Future<WasteResultModel> classifyImage(File imageFile);
}

class MockScanRepository implements ScanRepository {
  @override
  Future<WasteResultModel> classifyImage(File imageFile) async {
    // Real API jaisa 2-second delay simulate karna
    await Future.delayed(const Duration(seconds: 2));

    // Realistic dummy response
    return WasteResultModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: 'Plastic Bottle',
      confidence: 0.92,
      binColor: 'Blue Bin (Recyclable)',
      instructions: 'Rinse thoroughly, flatten, and discard with the cap on.',
      scannedAt: DateTime.now(),
      imagePath: imageFile.path,
    );
  }
}


