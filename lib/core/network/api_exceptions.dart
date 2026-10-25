import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: "Connection time out ho gaya. Internet check karein.",
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return ApiException(message: "Galat request bheji gayi (400).", statusCode: 400);
          case 401:
            return ApiException(message: "Unauthorized request (401).", statusCode: 401);
          case 404:
            return ApiException(message: "Resource nahi mila (404).", statusCode: 404);
          case 500:
            return ApiException(message: "Server down hai. Baad me try karein (500).", statusCode: 500);
          default:
            return ApiException(message: "Server error aaya: $statusCode", statusCode: statusCode);
        }

      case DioExceptionType.connectionError:
        return ApiException(message: "Internet connection nahi mil raha hai.");

      default:
        return ApiException(message: "Kuch galat ho gaya, dobara try karein.");
    }
  }

  @override
  String toString() => message;
}