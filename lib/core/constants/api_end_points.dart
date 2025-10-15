class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://lately-pure-developments-fill.trycloudflare.com';
  static const String imageBaseurl = 'http://localhost:5005/api';

  /// Auth
  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String verifyEmail = '$baseUrl/api/auth/verify-email';
  static const String resendCode = '$baseUrl/api/auth/resend-verification-email';
  static const String getMe = '$baseUrl/api/auth/me';
  static const String forgetPassword = '$baseUrl/api/auth/forgot-password';

  /// Home
  static const String getAllCategory = '$baseUrl/api/category/allCategories';

}