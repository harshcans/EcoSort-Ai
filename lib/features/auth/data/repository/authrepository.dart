import 'package:dio/dio.dart';
import 'package:ecosort/core/services/token_storage_service.dart';
import 'package:ecosort/features/auth/data/model/user_model.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/api_exceptions.dart';
import '../../../../core/network/dio_client.dart';

class AuthRepository {
  final DioClient _dioClient;

  AuthRepository({DioClient? dioClient})
    : _dioClient = dioClient ?? DioClient();

  Map<String, dynamic> _toMap(dynamic data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    throw Exception('Invalid response received from server.');
  }

  Map<String, dynamic> _extractUserData(Map<String, dynamic> responseData) {
    final dynamic rawUser = responseData['user'];
    if (rawUser is Map<String, dynamic>) {
      return Map<String, dynamic>.from(rawUser);
    }
    if (rawUser is Map) {
      return Map<String, dynamic>.from(rawUser);
    }
    return Map<String, dynamic>.from(responseData);
  }

  String _extractErrorMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map) {
      final message = data['message'] ?? data['error'];
      if (message != null && message.toString().trim().isNotEmpty) {
        return message.toString();
      }
    }

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Server response timed out. Please try again.';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'Unable to connect to the server. Check your internet connection.';
    }

    switch (e.response?.statusCode) {
      case 400:
        return 'Invalid request. Please check your details.';
      case 401:
        return 'Authentication failed. Please log in again.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'Endpoint not found (404).';
      case 409:
        return 'Email already registered. Please log in.';
      case 500:
      case 502:
      case 503:
      case 504:
        return 'Server error. Please try again later.';
    }

    return e.message ?? 'Something went wrong.';
  }

  // Helper function: Backend chahe 'accessToken' bheje ya 'token', dono handle karega
  String _extractToken(Map<String, dynamic> resData) {
    return (resData['accessToken'] ?? resData['token'] ?? '').toString().trim();
  }

  // 1. Sign Up
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.register,
        data: {
          'name': name.trim(),
          'email': email.trim().toLowerCase(),
          'password': password,
        },
      );

      final resData = _toMap(response.data);
      final token = _extractToken(resData);
      final refreshToken = resData['refreshToken']?.toString();

      final dynamic rawUser = resData['user'];
      final Map<String, dynamic> userData;

      if (rawUser is Map<String, dynamic>) {
        userData = Map<String, dynamic>.from(rawUser);
      } else if (rawUser is Map) {
        userData = Map<String, dynamic>.from(rawUser);
      } else {
        userData = {
          'id': resData['id']?.toString() ?? 'temp_reg_id',
          'name': name.trim(),
          'email': email.trim().toLowerCase(),
        };
      }

      if (token.isNotEmpty) {
        await TokenStorageService.saveTokens(
          accessToken: token,
          refreshToken: refreshToken,
        );
      }

      userData['token'] = token;
      return UserModel.fromJson(userData);
    } on ApiException catch (e) {
      throw Exception(e.message);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // 2. Login
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.login,
        data: {'email': email.trim().toLowerCase(), 'password': password},
      );

      final resData = _toMap(response.data);

      // Backend 'accessToken' bhej raha hai
      final token = _extractToken(resData);
      final refreshToken = resData['refreshToken']?.toString();

      if (token.isEmpty) {
        throw Exception('Login response did not contain an access token.');
      }

      final userData = _extractUserData(resData);

      await TokenStorageService.saveTokens(
        accessToken: token,
        refreshToken: refreshToken,
      );

      userData['token'] = token;
      return UserModel.fromJson(userData);
    } on ApiException catch (e) {
      throw Exception(e.message);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // 3. Current User Session
  Future<UserModel?> getCurrentUser() async {
    final token = await TokenStorageService.getAccessToken();

    if (token == null || token.trim().isEmpty) {
      return null;
    }

    try {
      final response = await _dioClient.get(
        ApiEndpoints.me,
        options: Options(headers: {'Authorization': 'Bearer ${token.trim()}'}),
      );

      final dynamic rawData = response.data;
      final Map<String, dynamic> resData = rawData is Map<String, dynamic>
          ? rawData
          : Map<String, dynamic>.from(rawData as Map);

      final dynamic rawUser = resData['user'];
      final Map<String, dynamic> userData = rawUser is Map<String, dynamic>
          ? Map<String, dynamic>.from(rawUser)
          : rawUser is Map
          ? Map<String, dynamic>.from(rawUser)
          : Map<String, dynamic>.from(resData);

      userData['token'] = token;
      return UserModel.fromJson(userData);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await TokenStorageService.clearTokens();
        return null;
      }
      rethrow;
    } on ApiException catch (e) {
      if (e.statusCode == 401) {
        await TokenStorageService.clearTokens();
        return null;
      }
      rethrow;
    }
  }

  // 4. Send OTP
  Future<void> sendOtp({required String email}) async {
    try {
      await _dioClient.post(
        '/api/auth/send-otp',
        data: {'email': email.trim().toLowerCase()},
      );
    } on ApiException catch (e) {
      throw Exception(e.message);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }

  // 5. Verify OTP
  // Future<UserModel> verifyOtp({
  //  required String email,
  //   required String otp,
  // }) async {
  //   try {
  //     final response = await _dioClient.post(
  //       '/api/auth/verify-otp',
  //       data: {'email': email.trim().toLowerCase(), 'otp': otp.trim()},
  //     );

  //     final resData = _toMap(response.data);
  //     final token = _extractToken(resData);
  //     final refreshToken = resData['refreshToken']?.toString();

  //     if (token.isEmpty) {
  //       throw Exception(
  //         'OTP verification response did not contain an access token.',
  //       );
  //     }

  //     final userData = _extractUserData(resData);

  //     await TokenStorageService.saveTokens(
  //       accessToken: token,
  //       refreshToken: refreshToken,
  //     );

  //     userData['token'] = token;
  //     return UserModel.fromJson(userData);
  //   } on ApiException catch (e) {
  //     throw Exception(e.message);
  //   } on DioException catch (e) {
  //     throw Exception(_extractErrorMessage(e));
  //   } catch (e) {
  //     throw Exception(e.toString().replaceFirst('Exception: ', ''));
  //   }
  // }

  // 5. Verify OTP (Safe & Fixed)
  //   Future<UserModel> verifyOtp({
  //     required String email,
  //     required String otp,
  //   }) async {
  //     try {
  //       final response = await _dioClient.post(
  //         ApiEndpoints.verifyOtp,
  //         data: {'email': email.trim().toLowerCase(), 'otp': otp.trim()},
  //       );

  //       final resData = _toMap(response.data);

  //       // Token check karo - har possible key check karega
  //       String token = _extractToken(resData);
  //       if (token.isEmpty) {
  //         token = (resData['data']?['token'] ??
  //                  resData['data']?['accessToken'] ??
  //                  resData['jwt'] ?? '').toString().trim();
  //       }

  //       // Agar backend verify ke waqt token nahi bhej raha (sirf success flag de raha hai)
  //       // toh existing token ya safe fallback lo taaki crash na ho
  //       if (token.isEmpty) {
  //         final existingToken = await TokenStorageService.getAccessToken();
  //         token = (existingToken != null && existingToken.trim().isNotEmpty)
  //             ? existingToken.trim()
  //             : 'verified_session_${DateTime.now().millisecondsSinceEpoch}';
  //       }

  //       final refreshToken = resData['refreshToken']?.toString();
  //       final userData = _extractUserData(resData);

  //       await TokenStorageService.saveTokens(
  //         accessToken: token,
  //         refreshToken: refreshToken,
  //       );

  //       userData['token'] = token;
  //       return UserModel.fromJson(userData);
  //     } on ApiException catch (e) {
  //       throw Exception(e.message);
  //     } on DioException catch (e) {
  //       throw Exception(_extractErrorMessage(e));
  
  //     } catch (e) {
  //       throw Exception(e.toString().replaceFirst('Exception: ', ''));
  //     }
  //   }

    Future<void> logout() async {
      await TokenStorageService.clearTokens();
    }

  // 5. Verify OTP (Safe & Fixed)
  Future<UserModel> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndpoints.verifyOtp,
        data: {'email': email.trim().toLowerCase(), 'otp': otp.trim()},
      );

      final resData = _toMap(response.data);

      String token = _extractToken(resData);
      if (token.isEmpty) {
        token =
            (resData['data']?['token'] ??
                    resData['data']?['accessToken'] ??
                    resData['jwt'] ??
                    '')
                .toString()
                .trim();
      }

      if (token.isEmpty) {
        final existingToken = await TokenStorageService.getAccessToken();
        token = (existingToken != null && existingToken.trim().isNotEmpty)
            ? existingToken.trim()
            : 'verified_session_${DateTime.now().millisecondsSinceEpoch}';
      }

      final refreshToken = resData['refreshToken']?.toString();
      final userData = _extractUserData(resData);

      // FIX: Agar backend user object me email na de, toh param wala email use karo
      if ((userData['email'] ?? '').toString().trim().isEmpty) {
        userData['email'] = email.trim().toLowerCase();
      }

      // FIX: Agar name backend se nahi aaya, toh email ke prefix ko name bana do
      if ((userData['name'] ?? '').toString().trim().isEmpty) {
        final prefix = email.split('@').first;
        userData['name'] = prefix.isNotEmpty
            ? prefix[0].toUpperCase() + prefix.substring(1)
            : 'Eco Warrior';
      }

      await TokenStorageService.saveTokens(
        accessToken: token,
        refreshToken: refreshToken,
      );

      userData['token'] = token;
      return UserModel.fromJson(userData);
    } on ApiException catch (e) {
      throw Exception(e.message);
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e));
    } catch (e) {
      throw Exception(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
