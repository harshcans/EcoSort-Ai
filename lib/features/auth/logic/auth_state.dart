import 'package:ecosort/features/auth/data/model/user_model.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial();
}

class AuthLoading extends AuthState {
  AuthLoading();
}

// User login hone ke baad usually user data ya token pass hota hai
class AuthAuthenticated extends AuthState {
  final UserModel user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {
  AuthUnauthenticated();
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
