import 'dart:io';
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'api_exceptions.dart';

class DioClient {
  late final Dio _dio;

  DioClient({String? customBaseUrl}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: customBaseUrl ?? ApiEndpoints.baseUrl,
        connectTimeout: ApiEndpoints.connectTimeout,
        receiveTimeout: ApiEndpoints.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Terminal me request aur response print karke dekhne ke liye
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  // 1. Simple GET request
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // 2. Simple POST request (JSON ke liye)
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // 3. Photo upload karne ke liye MULTIPART POST
  Future<Response> postMultipart(
    String path, {
    required File file,
    String fileKey = 'image',
    Map<String, dynamic>? extraFields,
  }) async {
    try {
      final fileName = file.path.split('/').last;

      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
        if (extraFields != null) ...extraFields,
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}