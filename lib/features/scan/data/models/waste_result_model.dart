class WasteResultModel {
  final String id;
  final String category;
  final double confidence;
  final String binColor;
  final String instructions;
  final DateTime scannedAt;
  final String? imagePath;

  WasteResultModel({
    required this.id,
    required this.category,
    required this.confidence,
    required this.binColor,
    required this.instructions,
    required this.scannedAt,
    this.imagePath,
  });
 
  // Backend ya Mock JSON se model banana
  factory WasteResultModel.fromJson(Map<String, dynamic> json) {
    return WasteResultModel(
      id: json['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
      category: json['category'] ?? 'Unknown',
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
      binColor: json['guidance']?['bin_color'] ?? json['binColor'] ?? 'General Waste',
      instructions: json['guidance']?['instructions'] ?? json['instructions'] ?? '',
      scannedAt: json['scannedAt'] != null 
          ? DateTime.parse(json['scannedAt']) 
          : DateTime.now(),
      imagePath: json['imagePath'],
    );
  }

  // Device par string/json me save karne ke liye
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'confidence': confidence,
      'binColor': binColor,
      'instructions': instructions,
      'scannedAt': scannedAt.toIso8601String(),
      'imagePath': imagePath,
    };
  }
}