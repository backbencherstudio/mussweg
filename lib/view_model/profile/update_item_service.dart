import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/token_storage.dart';

class UpdateItemService extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final tokenStorage = TokenStorage();

  String location = '';
  String categoryId = '';
  String categoryName = '';
  String size = '';
  String condition = '';
  String _productId = '';
  String? _message;

  bool _isLoading = false;
  bool _isUploaded = false;

  /// 🖼️ Local and Network Images
  List<File> images = []; // New images picked from device
  List<String> networkImages = []; // Existing images URLs from server

  String get productId => _productId;
  String? get message => _message;
  bool get isLoading => _isLoading;
  bool get isUploaded => _isUploaded;

  // ---------- Setters ----------
  void setProductId(String id) {
    _productId = id;
    notifyListeners();
  }

  void setCategoryName(String name) {
    categoryName = name;
    notifyListeners();
  }

  void setCategoryId(String id) {
    categoryId = id;
    notifyListeners();
  }

  void setCondition(String val) {
    condition = val;
    notifyListeners();
  }

  void setSize(String val) {
    size = val;
    notifyListeners();
  }

  void setLocation(String val) {
    location = val;
    notifyListeners();
  }

  void setMessage(String msg) {
    _message = msg;
    notifyListeners();
  }

  // ---------- 🖼️ Image Handling ----------
  Future<void> pickMultipleImages() async {
    final pickedFiles = await _picker.pickMultiImage(imageQuality: 80);
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      images.addAll(pickedFiles.map((x) => File(x.path)));
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < images.length) {
      images.removeAt(index);
      notifyListeners();
    }
  }

  void removeNetworkImage(String url) {
    networkImages.remove(url);
    notifyListeners();
  }

  void clearImages() {
    images.clear();
    networkImages.clear();
    notifyListeners();
  }

  void setNetworkImages(List<String> urls) {
    networkImages = urls;
    notifyListeners();
  }

  // ---------- 🧠 Main Update Logic ----------
  Future<bool> updatePost(
      String title,
      String description,
      String location,
      String color,
      String stock,
      String price,
      ) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.updateProductById(_productId));
    final token = await tokenStorage.getToken();
    if (token == null) {
      setMessage('Token missing');
      _isLoading = false;
      notifyListeners();
      return false;
    }

    try {
      final request = http.MultipartRequest('PATCH', url);
      request.headers['Authorization'] = 'Bearer $token';

      // Basic fields
      request.fields.addAll({
        'product_title': title,
        'product_description': description,
        'price': price,
        'location': location,
        'category_id': categoryId,
        'product_item_size': size,
        'color': color,
        'stock': stock,
        'condition': condition,
      });

      // // Include existing images as JSON string (backend expects this)
      // if (networkImages.isNotEmpty) {
      //   request.fields['existing_images'] = jsonEncode(networkImages);
      // }

      // Attach new images picked locally
      for (var file in images) {
        final mimeType = lookupMimeType(file.path);
        final fileName = path.basename(file.path);
        request.files.add(await http.MultipartFile.fromPath(
          'images', // Match backend field name for multiple images
          file.path,
          filename: fileName,
          contentType: mimeType != null ? MediaType.parse(mimeType) : null,
        ));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      final decoded = jsonDecode(responseBody);

      final message = decoded['message'];
      if (message is String) {
        setMessage(message);
        images = [];
      } else if (message is Map || message is List) {
        setMessage(jsonEncode(message));
      } else {
        setMessage('No message');
      }

      _isLoading = false;
      _isUploaded = response.statusCode == 200;
      notifyListeners();

      return decoded['success'] == true;
    } catch (e) {
      setMessage('Error updating product: $e');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
