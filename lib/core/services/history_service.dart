import 'package:dio/dio.dart';
import 'package:ecosort/core/network/api_endpoints.dart';
import '../services/token_storage_service.dart';

class HistoryService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: ApiEndpoints.connectTimeout,
      receiveTimeout: ApiEndpoints.receiveTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static Future<Options> _getAuthOptions() async {
    final token = await TokenStorageService.getAccessToken();
    return Options(
      headers: {
        if (token != null && token.trim().isNotEmpty)
          'Authorization': 'Bearer ${token.trim()}',
      },
    );
  }

  // GET /api/scans/history
  static Future<List<Map<String, dynamic>>> getAllScans() async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        ApiEndpoints.scanHistory,
        options: options,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        List<dynamic> list = [];

        if (data is List) {
          list = data;
        } else if (data is Map && data['scans'] is List) {
          list = data['scans'];
        } else if (data is Map && data['history'] is List) {
          list = data['history'];
        } else if (data is Map && data['data'] is List) {
          list = data['data'];
        }

        return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
      return [];
    } catch (_) {
      return [];
    }
  }

  // GET /api/scans/history/:id
  static Future<Map<String, dynamic>?> getScanById(String id) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.get(
        ApiEndpoints.scanDetail(id),
        options: options,
      );

      if (response.statusCode == 200 && response.data != null) {
        final data = response.data;
        if (data is Map<String, dynamic>) {
          return data['scan'] ?? data['data'] ?? data;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  // DELETE /api/scans/history/:id
  static Future<bool> deleteScan(String id) async {
    try {
      final options = await _getAuthOptions();
      final response = await _dio.delete(
        ApiEndpoints.deleteScan(id),
        options: options,
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (_) {
      return false;
    }
  }
}
