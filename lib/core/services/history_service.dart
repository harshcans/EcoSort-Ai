import 'package:hive_flutter/hive_flutter.dart';

class HistoryService {
  static const String boxName = 'scan_history_box';

  static Future<void> saveScan({
    required String imagePath,
    required String category,
    required double confidence,
    required String summary,
  }) async {
    final box = Hive.box(boxName);
    await box.add({
      'imagePath': imagePath,
      'category': category,
      'confidence': confidence,
      'summary': summary,
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  static List<Map<String, dynamic>> getAllScans() {
    final box = Hive.box(boxName);
    return box.values
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList()
        .reversed
        .toList();
  }

  static Future<void> clearHistory() async {
    final box = Hive.box(boxName);
    await box.clear();
  }

  static Future<void> seedDummyScansIfEmpty() async {
    final box = Hive.box(boxName);
    if (box.isEmpty) {
      await box.addAll([
        {
          'itemName': 'Plastic Bottle',
          'category': 'Plastic',
          'confidence': 0.95,
          'timestamp': DateTime.now().toIso8601String(),
        },
        {
          'itemName': 'Cardboard Box',
          'category': 'Paper',
          'confidence': 0.92,
          'timestamp': DateTime.now()
              .subtract(const Duration(hours: 3))
              .toIso8601String(),
        },
        {
          'itemName': 'Soda Can',
          'category': 'Metal',
          'confidence': 0.98,
          'timestamp': DateTime.now()
              .subtract(const Duration(days: 1))
              .toIso8601String(),
        },
        {
          'itemName': 'Glass Bottle',
          'category': 'Glass',
          'confidence': 0.89,
          'timestamp': DateTime.now()
              .subtract(const Duration(days: 2))
              .toIso8601String(),
        },
      ]);
    }
  }
}
