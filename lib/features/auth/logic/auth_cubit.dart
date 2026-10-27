// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../data/repository/authrepository.dart';
// import 'auth_state.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final AuthRepository _authRepository;

//   AuthCubit({required this._authRepository}) : super(AuthInitial());

//   // 1. Session check on start
//   Future<void> checkAuthStatus() async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.getCurrentUser();
//       if (user != null) {
//         emit(AuthAuthenticated(user));
//       } else {
//         emit(AuthUnauthenticated());
//       }
//     } catch (_) {
//       emit(AuthUnauthenticated());
//     }
//   }

//   // 2. Login
//   Future<bool> login({required String email, required String password}) async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.login(
//         email: email,
//         password: password,
//       );
//       emit(AuthAuthenticated(user));
//       return true;
//     } catch (e) {
//       emit(AuthError(e.toString().replaceAll('Exception: ', '')));
//       return false;
//     }
//   }

//   // 3. Sign Up (Returns bool for UI check)
//   Future<bool> signUp({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.signUp(
//         name: name,
//         email: email,
//         password: password,
//       );
//       // Agar backend direct authenticate kar raha hai
//       emit(AuthAuthenticated(user));
//       return true;
//     } catch (e) {
//       emit(AuthError(e.toString().replaceAll('Exception: ', '')));
//       return false;
//     }
//   }

//   // 4. Send / Resend OTP (Future ready - Returns bool)
//   Future<bool> sendOtp(String email) async {
//     emit(AuthLoading());
//     try {
//       await _authRepository.sendOtp(email: email);
//       emit(AuthOtpSent(email: email));
//       return true;
//     } catch (e) {
//       // Fallback UI ke flow ke liye safe true
//       emit(AuthOtpSent(email: email));
//       return true;
//     }
//   }

//   // 5. Verify OTP (Returns bool for OtpScreen)
//   Future<bool> verifyOtp({required String email, required String otp}) async {
//     emit(AuthLoading());
//     try {
//       final user = await _authRepository.verifyOtp(email: email, otp: otp);
//       emit(AuthAuthenticated(user));
//       return true;
//     } catch (e) {
//       emit(AuthError(e.toString().replaceAll('Exception: ', '')));
//       return false;
//     }
//   }

//   // 6. Logout
//   Future<void> logout() async {
//     emit(AuthLoading());
//     await _authRepository.logout();
//     emit(AuthUnauthenticated());
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/authrepository.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial());

  // Check existing session
  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.getCurrentUser();

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthError(_errorMessage(e)));
    }
  }

  // Login
  Future<bool> login({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.login(
        email: email,
        password: password,
      );

      emit(AuthAuthenticated(user));
      return true;
    } catch (e) {
      emit(AuthError(_errorMessage(e)));
      return false;
    }
  }

  // Sign up
  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.signUp(
        name: name,
        email: email,
        password: password,
      );

      // Signup ke baad OTP verification ke liye aage badho.
      emit(AuthOtpSent(email: email));
      return true;
    } catch (e) {
      emit(AuthError(_errorMessage(e)));
      return false;
    }
  }

  // Send / resend OTP
  Future<bool> sendOtp(String email) async {
    emit(AuthLoading());

    try {
      await _authRepository.sendOtp(email: email);
      emit(AuthOtpSent(email: email));
      return true;
    } catch (e) {
      emit(AuthError(_errorMessage(e)));
      return false;
    }
  }

  // Verify OTP
  Future<bool> verifyOtp({required String email, required String otp}) async {
    emit(AuthLoading());

    try {
      final user = await _authRepository.verifyOtp(email: email, otp: otp);

      // Successful verification ke baad hi authenticated state.
      emit(AuthAuthenticated(user));
      return true;
    } catch (e) {
      emit(AuthError(_errorMessage(e)));
      return false;
    }
  }

  // Logout — preserve this method
  Future<void> logout() async {
    emit(AuthLoading());

    try {
      await _authRepository.logout();
    } finally {
      emit(AuthUnauthenticated());
    }
  }

  String _errorMessage(Object error) {
    return error.toString().replaceFirst('Exception: ', '');
  }
}
