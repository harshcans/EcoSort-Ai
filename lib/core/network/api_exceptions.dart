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
          message:
              "Request timed out. Please check your internet connection and try again.",
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        switch (statusCode) {
          case 400:
            return ApiException(
              message:
                  "Bad request. Please check the information you provided (400).",
              statusCode: 400,
            );
          case 401:
            return ApiException(
              message:
                  "Unauthorized request. Please log in and try again (401).",
              statusCode: 401,
            );
          case 404:
            return ApiException(
              message: "The requested resource could not be found (404).",
              statusCode: 404,
            );
          case 500:
            return ApiException(
              message: "Internal server error. Please try again later (500).",
              statusCode: 500,
            );
          default:
            return ApiException(
              message: "A server error occurred. Status code: $statusCode.",
              statusCode: statusCode,
            );
        }
      case DioExceptionType.connectionError:
        return ApiException(
          message:
              "Unable to connect to the server. Please check your internet connection.",
        );
      default:
        return ApiException(message: "Something went wrong. Please try again.");
    }
  }
  @override
  String toString() => message;
}
