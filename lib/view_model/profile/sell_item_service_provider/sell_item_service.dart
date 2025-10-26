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

  File? image;
  final ImagePicker _picker = ImagePicker();

  // Image selection method
  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (pickedFile != null) {
      image = File(pickedFile.path);  // The image file should be stored here
      debugPrint('Image selected: ${image!.path}');  // Check if the image is picked correctly
      notifyListeners();
    } else {
      debugPrint('No image selected.');
    }
  }

  bool _isLoading = false;
  bool _isUploaded = false;

  bool get isLoading => _isLoading;
  bool get isUploaded => _isUploaded;

  final tokenStorage = TokenStorage();

  // Method for posting the item with the image via multipart request
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

      request.fields['product_title'] = title;
      request.fields['product_description'] = description;
      request.fields['price'] = price;
      request.fields['location'] = location;
      request.fields['product_item_size'] = size;
      request.fields['category_id'] = categoryId;
      request.fields['color'] = color;
      request.fields['stock'] = stock;
      request.fields['condition'] = condition;

      // Upload the image if selected
      if (image != null) {
        debugPrint('Uploading image...');
        String? mimeType = lookupMimeType(image!.path);  // Get the MIME type of the image
        String filename = path.basename(image!.path);    // Get the image filename

        // Adding the image to the multipart request
        request.files.add(
          await http.MultipartFile.fromPath(
            'image',  // Field name for image in the backend
            image!.path,  // Image file path
            filename: filename,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );
      } else {
        debugPrint('No image selected to upload.');
      }

      debugPrint('Selected CategoryId: $categoryId');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 409) {
        debugPrint('Create post successfully. Status: ${response.statusCode}');
        debugPrint('Response Body: $responseBody');
        _isLoading = false;
        _isUploaded = true;
        Map<String, dynamic> responseMap = jsonDecode(responseBody);
        if (responseBody.contains('409')) {
          setMessage(responseMap['message']['message']);
        }
        setMessage(responseMap['message']);
        notifyListeners();
        return responseMap['success'];
      } else {
        debugPrint('Failed to add details. Status: ${response.statusCode}');
        debugPrint('Request URL: ${request.url}');
        debugPrint('Request Headers: ${request.headers}');
        debugPrint('Request Fields: ${request.fields}');
        debugPrint('Response Body: $responseBody');
        _isLoading = false;
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
