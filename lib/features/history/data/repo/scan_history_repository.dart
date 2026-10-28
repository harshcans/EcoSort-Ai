import 'package:dio/dio.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/services/token_storage_service.dart';
import '../model/scan_history_model.dart';

class ScanHistoryRepository {
  final DioClient _dioClient;

  ScanHistoryRepository({required DioClient dioClient}) : _dioClient = dioClient;

  Future<List<ScanHistoryModel>> getScans() async {
    final token = await TokenStorageService.getAccessToken();

    final response = await _dioClient.get(
      ApiEndpoints.scanHistory,
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer ${token.trim()}',
        },
      ),
    );

    if (response.statusCode == 200 && response.data != null) {
      final dynamic raw = response.data;
      List<dynamic> items = [];

      if (raw is List) {
        items = raw;
      } else if (raw is Map && raw['scans'] is List) {
        items = raw['scans'];
      } else if (raw is Map && raw['data'] is List) {
        items = raw['data'];
      } else if (raw is Map && raw['history'] is List) {
        items = raw['history'];
      }

      return items
          .map((e) => ScanHistoryModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    return [];
  }

  Future<List<ScanHistoryModel>> getHistory() => getScans();

  Future<bool> deleteScan(String id) async {
    final token = await TokenStorageService.getAccessToken();
    final response = await _dioClient.dio.delete(
      ApiEndpoints.deleteScan(id),
      options: Options(
        headers: {
          if (token != null && token.isNotEmpty)
            'Authorization': 'Bearer ${token.trim()}',
        },
      ),
    );
    return response.statusCode == 200 || response.statusCode == 204;
  }
}