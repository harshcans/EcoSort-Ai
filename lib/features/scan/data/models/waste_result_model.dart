class WasteGuidance {
  final String summary;
  final List<String> steps;
  final String? binColor;
  final List<String> cautions;
  final String? instructions;

  WasteGuidance({
    required this.summary,
    required this.steps,
    this.binColor,
    this.cautions = const [],
    this.instructions,
  });

  factory WasteGuidance.fromJson(Map<String, dynamic> json) {
    final rawSteps = json['steps'];
    final rawCautions = json['cautions'];

    return WasteGuidance(
      summary: (json['summary'] ?? json['title'] ?? json['instructions'] ?? '')
          .toString(),
      steps: rawSteps is List
          ? rawSteps.map((item) => item.toString()).toList()
          : <String>[],
      binColor: json['bin_color']?.toString() ?? json['binColor']?.toString(),
      cautions: rawCautions is List
          ? rawCautions.map((item) => item.toString()).toList()
          : <String>[],
      instructions: json['instructions']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'summary': summary,
      'steps': steps,
      'bin_color': binColor,
      'cautions': cautions,
      'instructions': instructions,
    };
  }
}

class WasteResultModel {
  final bool success;
  final String status;
  final String category;
  final double confidence;
  final WasteGuidance? guidance;
  final String? message;
  final DateTime scannedAt;
  final String? imagePath;
  final bool isUncertain;

  WasteResultModel({
    required this.success,
    required this.status,
    required this.category,
    required this.confidence,
    this.guidance,
    this.message,
    required this.scannedAt,
    this.imagePath,
    this.isUncertain = false,
  });

  factory WasteResultModel.fromJson(Map<String, dynamic> json) {
    final rawCategory = json['category'];
    final category = rawCategory?.toString() ?? '';

    final rawConfidence = json['confidence'];
    final confidence = rawConfidence is num
        ? rawConfidence.toDouble()
        : double.tryParse(rawConfidence?.toString() ?? '') ?? 0.0;

    final rawGuidance = json['guidance'];

    final WasteGuidance? guidance = rawGuidance is Map
        ? WasteGuidance.fromJson(Map<String, dynamic>.from(rawGuidance))
        : null;

    final statusFromApi = json['status']?.toString() ?? '';

    final uncertainFromApi =
        json['is_uncertain'] == true || json['isUncertain'] == true;

    final isUncertain =
        uncertainFromApi ||
        statusFromApi == 'uncertain' ||
        (statusFromApi.isEmpty && category.isNotEmpty && confidence < 0.60);

    final status = statusFromApi.isNotEmpty
        ? statusFromApi
        : (isUncertain ? 'uncertain' : 'classified');

    final rawSuccess = json['success'];

    final success = rawSuccess is bool
        ? rawSuccess
        : category.isNotEmpty &&
              status != 'error' &&
              status != 'invalid_image' &&
              status != 'unsupported';

    return WasteResultModel(
      success: success,
      status: status,
      category: category.isNotEmpty ? category : 'other',
      confidence: confidence,
      guidance: guidance,
      message: json['message']?.toString(),
      scannedAt: DateTime.now(),
      imagePath:
          json['imagePath']?.toString() ?? json['image_path']?.toString(),
      isUncertain: isUncertain,
    );
  }

  bool get isClassified => status == 'classified' && !isUncertain;
}
