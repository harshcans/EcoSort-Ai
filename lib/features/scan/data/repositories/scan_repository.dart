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

    // Realistic dummy response according to new WasteResultModel
    return WasteResultModel(
      success: true,
      status: 'classified',
      category: 'plastic',
      confidence: 0.92,
      guidance: WasteGuidance(
        summary:
            'Plastic bottles are recyclable. Ensure they are empty and clean before disposal.',
        steps: [
          'Empty any remaining liquids.',
          'Rinse the bottle lightly.',
          'Flatten the bottle and recap it.',
          'Drop it into the dry recyclable bin.',
        ],
      ),
      scannedAt: DateTime.now(),
      imagePath: imageFile.path,
    );
  }
}
