import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/user_model.dart';
import 'authrepository.dart';
import '../../../../core/network/api_endpoints.dart';
import '../../../../core/network/dio_client.dart';

class MockAuthRepository implements AuthRepository {
  static const String _userKey = 'ecosort_current_user';

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    // 1-second delay for realistic network feel
    await Future.delayed(const Duration(seconds: 1));

    if (password.length < 8) {
      throw Exception('Password must be at least 6 characters long.');
    }

    final user = UserModel(
      id: 'mock_user_101',
      name: email.split('@').first.toUpperCase(),
      email: email,
      token: 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
    );

    // Save user session locally
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));

    return user;
  }

  @override
  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    if (name.trim().isEmpty || password.length < 6) {
      throw Exception('Please provide a valid name and 6+ character password.');
    }

    final user = UserModel(
      id: 'mock_user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      token: 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}',
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));

    return user;
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userRaw = prefs.getString(_userKey);

    if (userRaw != null) {
      final Map<String, dynamic> userMap = jsonDecode(userRaw);
      return UserModel.fromJson(userMap);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Send OTP
  Future<bool> sendOtp({required String email}) async {
    final dio = DioClient();
    try {
      final response = await dio.post(
        ApiEndpoints.sendOtp,
        data: {'email': email},
      );
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp({required String email, required String otp}) async {
    final dio = DioClient();
    try {
      final response = await dio.post(
        ApiEndpoints.verifyOtp,
        data: {'email': email, 'otp': otp},
      );
      return response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
