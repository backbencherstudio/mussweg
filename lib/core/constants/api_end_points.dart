class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'https://carries-customize-incident-ghz.trycloudflare.com';
  static const String imageBaseurl = 'https://carries-customize-incident-ghz.trycloudflare.com';

  /// Auth
  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String verifyEmail = '$baseUrl/api/auth/verify-email';
  static const String resendCode = '$baseUrl/api/auth/resend-verification-email';
  static const String getMe = '$baseUrl/api/auth/me';
  static const String forgetPassword = '$baseUrl/api/auth/forgot-password';

  /// Home
  static const String getAllCategory = '$baseUrl/api/category/allCategories';
  static String getProductsByCategory(String id) => '$baseUrl/api/products/category/$id/latest-products';
  static String getWishList = '$baseUrl/api/wishlist/userwishlist';
  static String createWishListProduct = '$baseUrl/api/wishlist/create';
  static String updateProfile = '$baseUrl/api/auth/update';
  static String userAllProducts = '$baseUrl/api/products/user-all-products/?page=1&perPage=10';

  static String createBoost(String id) => '$baseUrl/api/products/create-boost';


}