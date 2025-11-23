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
  static String getClientDetails(String id) =>
      '$baseUrl/api/profile/client-deshborad/$id';
  static String getMyDashboardDetails = '$baseUrl/api/profile/me/dashboard';
  static const String getUserProfileDetails = '$baseUrl/api/profile/me';
  static const String forgetPassword = '$baseUrl/api/auth/forgot-password';
  static const String resetPassword = '$baseUrl/api/auth/reset-password';

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

  static String createBoost = '$baseUrl/api/products/create-boost';

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

  //  Sell product
  static String totalSellProduct(int page, int limit) =>
      '$baseUrl/api//dashborad/total-selling-item/?page=$page&perPage=$limit';
  static String sellPendingProduct =
      '$baseUrl/api/dashborad/selling-pending-item';
  static String sellDeliveredProduct =
      '$baseUrl/api/dashborad/selling-delivered-item';
  static String sellCancelProduct =
      '$baseUrl/api/dashborad/selling-cancelled-item';

  //
  static const String getRequestedBidsForSeller =
      '$baseUrl/api/bid/seller-product-bids';
  static const String getAcceptedBidsForSeller =
      '$baseUrl/api/bid/seller-accepted-bids';
  static String updateBidStatus(String productId) =>
      '$baseUrl/api/bid/update-status/$productId';
  static const String getOnProgressBidsForBuyer =
      '$baseUrl/api/bid/my-pending-bids';
  static const String getAcceptedBidsForBuyer =
      '$baseUrl/api/bid/my-accepted-bids';

  static String createReview = '$baseUrl/api/review/create';
  static String createMusswegDisposal(String productId) =>
      '$baseUrl/api/disposal/create/$productId';
  static String getDisposalItems(String status) =>
      '$baseUrl/api/disposal/my-disposal-requests/$status';
  static String getSearchProducts(int page, String Q) =>
      '$baseUrl/api/products/search?page=$page&perPage=10&search=$Q';
  static String filterProducts = '$baseUrl/api/products/filter';

  //chat
  static String getChatList =
      "$baseUrl/api/chat/conversation/conversation-list";
  static String getAllMessage(String conversationId, int page, int limit) =>
      "$baseUrl/api/chat/message/all-message/$conversationId?page=$page&perPage=$limit";
  static String sendMessage = "$baseUrl/api/chat/message/send-message";

  static String createConversation =
      "$baseUrl/api/chat/conversation/create-conversation";

  // payment

  static String createCart = "$baseUrl/api/cart/create";
  static String getMyCart = "$baseUrl/api/cart/my-cart";
  static String updateCart(String cartItem) => "$baseUrl/api/cart/update/$cartItem";
  static String orderCreate = "$baseUrl/api/order/create";
  static String myOrderList = "$baseUrl/api/order/my-orders";
}
