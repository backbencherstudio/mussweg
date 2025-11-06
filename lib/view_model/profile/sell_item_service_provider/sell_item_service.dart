import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/services/token_storage.dart';

class SellItemService extends ChangeNotifier {
  String location = '';
  String categoryId = '';
  String categoryName = '';
  String size = '';
  String condition = '';

  void setLocation(String value) {
    location = value;
    debugPrint('---- Location : $location ----');
    notifyListeners();
  }

  void setCategoryName(String value) {
    categoryName = value;
    debugPrint('---- CategoryName : $categoryName ----');
    notifyListeners();
  }

  void setCategoryId(String value) {
    categoryId = value;
    debugPrint('---- CategoryId : $categoryId ----');
    notifyListeners();
  }

  void setSize(String value) {
    size = value;
    debugPrint('---- Size : $size ----');
    notifyListeners();
  }

  void setCondition(String value) {
    condition = value;
    debugPrint('---- Condition : $condition ----');
    notifyListeners();
  }

  String? _message;
  String? get message => _message;

  void setMessage(String message) {
    _message = message;
    debugPrint('---- Message : $_message ----');
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  final List<File> _images = []; // multiple images

  List<File> get images => _images;

  // 🖼️ Pick multiple images
  Future<void> pickMultipleImages() async {
    final pickedFiles = await _picker.pickMultiImage(imageQuality: 80);

    if (pickedFiles.isNotEmpty) {
      _images.clear();
      _images.addAll(pickedFiles.map((xfile) => File(xfile.path)));
      debugPrint('Selected ${_images.length} images');
      for (var img in _images) {
        debugPrint('Image path: ${img.path}');
      }
      notifyListeners();
    } else {
      debugPrint('No images selected.');
    }
  }

  bool _isLoading = false;
  bool _isUploaded = false;

  bool get isLoading => _isLoading;
  bool get isUploaded => _isUploaded;

  final tokenStorage = TokenStorage();

  // 📨 Create Post (with multiple images)
  Future<bool> createPost(
      String title,
      String description,
      String location,
      String color,
      String stock,
      String price,
      ) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.createProduct);

    try {
      final accessToken = await tokenStorage.getToken();
      if (accessToken == null) {
        debugPrint('Access token not found. Cannot add item.');
        return false;
      }

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $accessToken';

      // Text fields
      request.fields['product_title'] = title;
      request.fields['product_description'] = description;
      request.fields['price'] = price;
      request.fields['location'] = location;
      request.fields['product_item_size'] = size;
      request.fields['size'] = size;
      request.fields['category_id'] = categoryId;
      request.fields['color'] = color;
      request.fields['stock'] = stock;
      request.fields['condition'] = condition;

      // 🖼️ Upload all selected images
      if (_images.isNotEmpty) {
        debugPrint('Uploading ${_images.length} images...');
        for (var image in _images) {
          final mimeType = lookupMimeType(image.path);
          final filename = path.basename(image.path);
          request.files.add(
            await http.MultipartFile.fromPath(
              'images', // 👈 adjust field name based on backend expectation
              image.path,
              filename: filename,
              contentType: mimeType != null ? MediaType.parse(mimeType) : null,
            ),
          );
        }
      } else {
        debugPrint('No images selected to upload.');
      }

      debugPrint('Selected CategoryId: $categoryId');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _isLoading = false;

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 409) {
        debugPrint('Create post successful. Status: ${response.statusCode}');
        debugPrint('Response Body: $responseBody');

        _isUploaded = true;
        final responseMap = jsonDecode(responseBody);

        if (responseBody.contains('409')) {
          setMessage(responseMap['message']['message']);
        } else {
          setMessage(responseMap['message']);
        }

        notifyListeners();
        return responseMap['success'] ?? false;
      } else {
        debugPrint('Failed to add details. Status: ${response.statusCode}');
        debugPrint('Response Body: $responseBody');
        _isUploaded = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      debugPrint('Error adding details: $error');
      _isLoading = false;
      _isUploaded = false;
      notifyListeners();
      return false;
    }
  }
}
