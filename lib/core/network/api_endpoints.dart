class ApiEndpoints {
  // Render Production URL
  static const String baseUrl = "https://ecosort-ai-u1ln.onrender.com";

  // Auth Routes
  static const String register = "/api/auth/register";
  static const String login = "/api/auth/login";
  static const String me = "/api/auth/me";

  // ML Classifier Route
  static const String classifyWaste = "/api/classify";

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 120);
  static const Duration receiveTimeout = Duration(seconds: 120);
}
