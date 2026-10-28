// class ApiEndpoints {
//   // Render Production URL
//   static const String baseUrl = "https://ecosort-ai-u1ln.onrender.com";

//   // Auth Routes
//   static const String register = "/api/auth/register";
//   static const String login = "/api/auth/login";
//   static const String me = "/api/auth/me";

//   // ML Classifier Route
//   static const String classifyWaste = "/api/classify";

//   // history ka liya hai
//   static const String scanHistory = "/api/scans/history";
//   static String scanDetail(String id) => "/api/scans/history/$id";
//   static String deleteScan(String id) => "/api/scans/history/$id";

//   // Timeouts
//   static const Duration connectTimeout = Duration(seconds: 120);
//   static const Duration receiveTimeout = Duration(seconds: 120);
// }
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  // Render Production URL
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  // System & Meta Routes
  static const String health = "/api/health";
  static const String categories = "/api/categories";

  // Auth Routes
  static const String register = "/api/auth/register";
  static const String verifyOtp = "/api/auth/verify-otp";
  static const String login = "/api/auth/login";
  static const String logout = "/api/auth/logout";
  static const String refreshToken = "/api/auth/refresh-token";
  static const String me = "/api/auth/me";

  // ML Classifier Route
  static const String classifyWaste = "/api/classify";

  // History Routes
  static const String scanHistory = "/api/scans/history";
  static String scanDetail(String id) => "/api/scans/history/$id";
  static String deleteScan(String id) => "/api/scans/history/$id";

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 120);
  static const Duration receiveTimeout = Duration(seconds: 120);
}
