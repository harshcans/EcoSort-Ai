// import 'dart:io';

// import 'package:dio/dio.dart';

// import '../services/token_storage_service.dart';
// import 'api_endpoints.dart';
// import 'api_exceptions.dart';

// class DioClient {
//   late final Dio _dio;

//   DioClient({String? customBaseUrl}) {
//     _dio = Dio(
//       BaseOptions(
//         baseUrl: customBaseUrl ?? ApiEndpoints.baseUrl,
//         connectTimeout: ApiEndpoints.connectTimeout,
//         receiveTimeout: ApiEndpoints.receiveTimeout,
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//       ),
//     );

//     _dio.interceptors.add(
//       LogInterceptor(
//         request: true,
//         requestBody: true,
//         responseBody: true,
//         error: true,
//       ),
//     );
//   }

//   Future<Response> get(
//     String path, {
//     Map<String, dynamic>? queryParameters,
//     Options? options,
//   }) async {
//     try {
//       return await _dio.get(
//         path,
//         queryParameters: queryParameters,
//         options: options,
//       );
//     } on DioException catch (e) {
//       throw ApiException.fromDioError(e);
//     }
//   }

//   Future<Response> post(String path, {dynamic data, Options? options}) async {
//     try {
//       return await _dio.post(path, data: data, options: options);
//     } on DioException catch (e) {
//       throw ApiException.fromDioError(e);
//     }
//   }

//   Future<Response> postMultipart(
//     String path, {
//     required File file,
//     String fileKey = 'image',
//     Map<String, dynamic>? extraFields,
//   }) async {
//     try {
//       final token = await TokenStorageService.getAccessToken();

//       if (token == null || token.trim().isEmpty) {
//         throw ApiException(
//           message: 'Access token is missing. Please log in again.',
//           statusCode: 401,
//         );
//       }

//       final formData = FormData.fromMap({
//         fileKey: await MultipartFile.fromFile(
//           file.path,
//           filename: file.uri.pathSegments.isNotEmpty
//               ? file.uri.pathSegments.last
//               : 'waste_image.jpg',
//         ),
//         if (extraFields != null) ...extraFields,
//       });

//       return await _dio.post(
//         path,
//         data: formData,
//         options: Options(
//           contentType: Headers.multipartFormDataContentType,
//           headers: {
//             'Authorization': 'Bearer ${token.trim()}',
//             'Accept': 'application/json',
//           },
//         ),
//       );
//     } on DioException catch (e) {
//       throw ApiException.fromDioError(e);
//     }
//   }
// }

import 'dart:io';

import 'package:dio/dio.dart';

import '../services/token_storage_service.dart';
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

    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  // GET request
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // POST request
  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      return await _dio.post(path, data: data, options: options);
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }

  // Multipart image upload with authentication
  Future<Response> postMultipart(
    String path, {
    required File file,
    String fileKey = 'image',
    Map<String, dynamic>? extraFields,
  }) async {
    try {
      // Read the token saved after successful authentication.
      final token = await TokenStorageService.getAccessToken();

      if (token == null || token.trim().isEmpty) {
        throw ApiException(
          message: 'Access token missing. Please log in again.',
          statusCode: 401,
        );
      }

      if (!await file.exists()) {
        throw ApiException(message: 'Selected image file does not exist.');
      }

      final fileName = file.path.split(Platform.pathSeparator).last;

      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(file.path, filename: fileName),
        if (extraFields != null) ...extraFields,
      });

      final response = await _dio.post(
        path,
        data: formData,
        options: Options(
          contentType: Headers.multipartFormDataContentType,
          headers: {
            'Authorization': 'Bearer ${token.trim()}',
            'Accept': 'application/json',
          },
        ),
      );

      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    }
  }
}
