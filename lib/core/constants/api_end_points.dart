class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://performing-decorative-heating-state.trycloudflare.com';
  static const String imageBaseurl = 'http://localhost:5005/api';

  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String verifyEmail = '$baseUrl/api/auth/verify-email';
  static const String resendCode = '$baseUrl/api/auth/resend-verification-email';

}