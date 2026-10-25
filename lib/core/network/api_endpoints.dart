class ApiEndpoints {
  // Backend server ka main link
  static const String baseUrl = "https://api.ecosort.ai/v1";

  // Scan aur Waste classification route
  static const String classifyWaste = "/scan/classify";


  // otp ki backchodi ka liya ... otp evolved
  static const String sendOtp = "/auth/send-otp";
  static const String verifyOtp = "/auth/verify-otp";

  // Timeouts (agar 15 sec tak net na chale toh error throw karega)
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);
}