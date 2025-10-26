import 'package:flutter/material.dart';
import 'package:mussweg/data/model/whistlist/favourite_product_model.dart';

import '../../core/constants/api_end_points.dart';
import '../../core/services/api_service.dart';

class WhistlistProviderOfGetFavouriteProduct extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  WishListModel? _wishlistModel;
  WishListModel? get wishlistModel => _wishlistModel;

  final ApiService _apiService = ApiService();

  int _currentPage = 1;
  int get currentPage => _currentPage;

  bool _hasNextPage = false;
  bool get hasNextPage => _hasNextPage;

  bool _isPaginationLoading = false;
  bool get isPaginationLoading => _isPaginationLoading;

  Future<bool> getWishlistProduct() async {
    _isLoading = true;
    _currentPage = 1;
    notifyListeners();

    try {
      final response = await _apiService.get(ApiEndpoints.getWishList(_currentPage, 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        _isLoading = false;
        _wishlistModel = WishListModel.fromJson(response.data);
        _hasNextPage = _wishlistModel?.pagination.hasNextPage ?? false;
        _errorMessage = response.data['message'] ?? '';
        notifyListeners();
        return response.data['success'];
      } else {
        _isLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error fetching wishlist products: $e");
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loadMoreWishlistProduct() async {
    if (_isPaginationLoading || !_hasNextPage) {
      return false;
    }

    _isPaginationLoading = true;
    notifyListeners();

    try {
      _currentPage++;
      final response = await _apiService.get(ApiEndpoints.getWishList(_currentPage, 10));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final newWishlistModel = WishListModel.fromJson(response.data);
        _wishlistModel?.data.addAll(newWishlistModel.data);
        _hasNextPage = newWishlistModel.pagination.hasNextPage;

        _isPaginationLoading = false;
        _errorMessage = response.data['message'] ?? '';
        notifyListeners();
        return response.data['success'];
      } else {
        _isPaginationLoading = false;
        _errorMessage = response.data['message'] ?? 'Something went wrong';
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error loading more wishlist products: $e");
      _errorMessage = e.toString();
      _isPaginationLoading = false;
      notifyListeners();
      return false;
    }
  }
}
