import 'package:ecosort/features/auth/data/model/user_model.dart';
import 'package:ecosort/features/auth/data/repository/authrepository.dart';
import 'package:ecosort/features/auth/data/repository/mockauthrepository.dart';
import 'package:ecosort/features/auth/logic/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required this._authRepository}) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    try {
      final UserModel? currentUser = await _authRepository.getCurrentUser();
      if (currentUser != null) {
        emit(AuthAuthenticated(currentUser));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (_) {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll("expectation", '')));
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );
      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString().replaceAll("Exception: ", "")));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    await _authRepository.logout();
    emit(AuthUnauthenticated());
  }

  // 1. Send OTP
  Future<bool> sendOtp(String email) async {
    emit(AuthLoading());
    try {
      final repo = MockAuthRepository();
      final success = await repo.sendOtp(email: email);
      emit(AuthInitial());
      return success;
    } catch (e) {
      emit(AuthError(e.toString()));
      return false;
    }
  }

  // 2. Verify OTP
  Future<bool> verifyOtp({required String email, required String otp}) async {
    emit(AuthLoading());
    try {
      final repo = MockAuthRepository();
      final success = await repo.verifyOtp(email: email, otp: otp);
      if (success) {
        emit(AuthInitial());
      }
      return success;
    } catch (e) {
      emit(AuthError(e.toString()));
      return false;
    }
  }
}
