class ApiEndpoints {
  ApiEndpoints._();
  static const String baseUrl = 'http://192.168.7.14:5005';

  /// Auth
  static const String register = '$baseUrl/api/auth/register';
  static const String login = '$baseUrl/api/auth/login';
  static const String verifyEmail = '$baseUrl/api/auth/verify-email';
  static const String resendCode =
      '$baseUrl/api/auth/resend-verification-email';
  static const String getMe = '$baseUrl/api/auth/me';
  static const String forgetPassword = '$baseUrl/api/auth/forgot-password';

  /// Home
  static const String getAllCategory = '$baseUrl/api/category/allCategories';
  static String getProductsByCategory(String id, int page, int limit) =>
      '$baseUrl/api/products/category/$id/latest-products/?page=$page&perPage=$limit';
  static String getWishList(int page, int limit) =>
      '$baseUrl/api/wishlist/userwishlist/?page=$page&perPage=$limit';
  static String createWishListProduct = '$baseUrl/api/wishlist/create';
  static String updateProfile = '$baseUrl/api/auth/update';
  static String userAllProducts =
      '$baseUrl/api/products/user-all-products/?page=1&perPage=10';
  static String createProduct = '$baseUrl/api/products/create';
  static String getProductDetailsById(String id) =>
      '$baseUrl/api/products/singleproduct/$id';
  static String updateProductById(String id) =>
      '$baseUrl/api/products/updatebyid/$id';

  static String createBoost(String id) => '$baseUrl/api/products/create-boost';

  static String getProductBids(String id) =>
      '$baseUrl/api/bid/singleproductbid/$id';
  static String createBid = '$baseUrl/api/bid/create';


  //  bought product
  static String totalBoughtProduct(int page, int limit) =>
      '$baseUrl/api/dashborad/total-brought-item/?page=$page&perPage=$limit';
  static String boughtPendingProduct =
      '$baseUrl/api/dashborad/bought-pending-item';
  static String boughtDeliveredProduct =
      '$baseUrl/api/dashborad/bought-delivered-item';
  static String boughtCancelProduct =
      '$baseUrl/api/dashborad/bought-cancelled-item';
}
