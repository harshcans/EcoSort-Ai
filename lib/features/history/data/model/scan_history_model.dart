class ScanHistoryModel {
  final String id;
  final String title;
  final String category;
  final double confidence;
  final String? imagePath;
  final String? summary;
  final List<String> steps;

  const ScanHistoryModel({
    required this.id,
    required this.title,
    required this.category,
    required this.confidence,
    this.imagePath,
    this.summary,
    this.steps = const [],
  });

  factory ScanHistoryModel.fromJson(Map<String, dynamic> json) {
    // 1. Title deep fallback extraction
    String extractedTitle = 'Scanned Item';
    final candidateTitle =
        json['title'] ??
        json['itemName'] ??
        json['name'] ??
        json['item'] ??
        json['wasteName'] ??
        json['category'];
    if (candidateTitle != null &&
        candidateTitle.toString().trim().isNotEmpty &&
        candidateTitle.toString().trim() != 'Unknown Item') {
      extractedTitle = candidateTitle.toString().trim();
    } else if (json['guidance'] is Map && json['guidance']['summary'] != null) {
      extractedTitle = json['guidance']['summary'].toString().split('.').first;
    }

    // 2. Category extraction & General -> Organic replace
    String extractedCat =
        (json['category'] ?? json['wasteType'] ?? json['type'] ?? 'Organic')
            .toString();
    if (extractedCat.trim().isEmpty ||
        extractedCat.toLowerCase() == 'general' ||
        extractedCat.toLowerCase() == 'unknown') {
      extractedCat = 'Organic';
    }

    // 3. Image URL / Path resolution
    final rawImg =
        json['imagePath'] ??
        json['image_path'] ??
        json['imageUrl'] ??
        json['image_url'] ??
        json['image'];
    final imagePath = rawImg?.toString();

    // 4. Summary & Steps
    String? summary = json['summary']?.toString();
    List<String> stepsList = [];

    if (json['guidance'] is Map) {
      summary ??=
          json['guidance']['summary']?.toString() ??
          json['guidance']['title']?.toString();
      final rawSteps = json['guidance']['steps'];
      if (rawSteps is List) {
        stepsList = rawSteps.map((e) => e.toString()).toList();
      }
    }

    if (stepsList.isEmpty && json['steps'] is List) {
      stepsList = (json['steps'] as List).map((e) => e.toString()).toList();
    }

    // Agar backend se steps nahi aaye toh professional disposal guide fallback
    if (stepsList.isEmpty) {
      final catLower = extractedCat.toLowerCase();
      if (catLower.contains('plastic')) {
        stepsList = [
          'Rinse bottle or container to remove residual liquids.',
          'Crush the item to save space in the bin.',
          'Place in the designated blue recycling bin.',
        ];
      } else if (catLower.contains('organic')) {
        stepsList = [
          'Separate from plastic wrappers or staples.',
          'Dispose of in the green organic compost bin.',
          'Keep dry to avoid odors before scheduled disposal.',
        ];
      } else if (catLower.contains('e-waste')) {
        stepsList = [
          'Do not throw with regular household trash.',
          'Remove batteries if detachable.',
          'Drop off at an authorized electronic recycling center.',
        ];
      } else if (catLower.contains('glass')) {
        stepsList = [
          'Ensure glass is free from heavy residue.',
          'Do not break; place intact in glass recycling bin.',
          'Wrap broken pieces carefully before discarding.',
        ];
      } else if (catLower.contains('paper')) {
        stepsList = [
          'Ensure paper is clean and dry.',
          'Flatten cardboard boxes completely.',
          'Deposit into the yellow/blue paper collection bin.',
        ];
      } else {
        stepsList = [
          'Separate organic components if applicable.',
          'Check local community recycling rules.',
          'Ensure the item is placed into the correct sorting bin.',
        ];
      }
    }

    return ScanHistoryModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: extractedTitle,
      category: extractedCat,
      confidence: (json['confidence'] as num?)?.toDouble() ?? 0.95,
      imagePath: imagePath,
      summary: summary ?? 'Ensure proper sorting to help recycling facilities.',
      steps: stepsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'confidence': confidence,
      if (imagePath != null) 'imagePath': imagePath,
      if (summary != null) 'summary': summary,
      'steps': steps,
    };
  }
}
