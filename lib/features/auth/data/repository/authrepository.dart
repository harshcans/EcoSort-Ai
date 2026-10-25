import '../model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login({required String email, required String password});

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<UserModel?> getCurrentUser();
}
