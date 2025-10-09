class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://performing-decorative-heating-state.trycloudflare.com/api';
  static const String imageBaseurl = 'http://localhost:5005/api';

  static const String register = '$baseUrl/auth/register';
  static const String login = '$baseUrl/auth/login';
  static const String verifyEmail = '$baseUrl/auth/verify-email';

}