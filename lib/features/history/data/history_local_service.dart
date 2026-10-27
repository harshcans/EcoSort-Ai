import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../scan/data/models/waste_result_model.dart';

class HistoryLocalService {
  static const String _historyKey = 'eco_sort_scan_history';

  // Scan result save karna
  Future<void> saveScan(WasteResultModel result) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> currentList = prefs.getStringList(_historyKey) ?? [];

    // Naya scan list me sabse upar add karna
    // currentList.insert(0, jsonEncode(result.toJson()));

    // Memory limit: maximum last 50 scans save rakho
    if (currentList.length > 50) {
      currentList.removeLast();
    }

    await prefs.setStringList(_historyKey, currentList);
  }

  // Saari history fetch karna
  Future<List<WasteResultModel>> getScans() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> rawList = prefs.getStringList(_historyKey) ?? [];

    return rawList
        .map((item) => WasteResultModel.fromJson(jsonDecode(item)))
        .toList();
  }

  // History clear karna
  Future<void> clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
  }
}