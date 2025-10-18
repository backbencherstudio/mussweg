// import 'dart:convert';
// import 'dart:io';
// import 'package:path/path.dart' as path;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';
// import 'core/constants/api_end_points.dart';
// import 'core/services/token_storage.dart';
//
// class PostViewmodel extends ChangeNotifier {
//   String? _message;
//
//   String? get message => _message;
//
//   void setMessage(String message) {
//     _message = message;
//     notifyListeners();
//   }
//
//   String _selectedOption = '';
//
//   String get selectedOption => _selectedOption;
//
//   void selectOption(String option) {
//     _selectedOption = option;
//     debugPrint("The category type $_selectedOption");
//     notifyListeners();
//   }
//
//   String _selectedOptionId = '';
//
//   String get selectedOptionId => _selectedOptionId;
//
//   void selectOptionId(String option) {
//     _selectedOptionId = option;
//     notifyListeners();
//   }
//
//   String _subSelectedOption = '';
//
//   String get subSelectedOption => _subSelectedOption;
//
//   void subSelectOption(String option) {
//     _subSelectedOption = option;
//     notifyListeners();
//   }
//
//   String _subSelectedOptionId = '';
//
//   String get subSelectedOptionId => _subSelectedOptionId;
//
//   void subSelectOptionId(String option) {
//     _subSelectedOptionId = option;
//     notifyListeners();
//   }
//
//   bool _allowChatOnly = false;
//   bool _showChatInfo = false;
//
//   bool get allowChatOnly => _allowChatOnly;
//   bool get showChatInfo => _showChatInfo;
//
//   void setAllowChatOnly(bool value) {
//     _allowChatOnly = value;
//     notifyListeners();
//   }
//
//   void setShowChatInfo(bool value) {
//     _showChatInfo = value;
//     notifyListeners();
//   }
//
//   File? image;
//   final ImagePicker _picker = ImagePicker();
//
//   Future<void> pickImage() async {
//     final pickedFile = await _picker.pickImage(
//       source: ImageSource.gallery,
//       imageQuality: 80,
//     );
//     if (pickedFile != null) {
//       image = File(pickedFile.path);
//       notifyListeners();
//     } else {
//       debugPrint('No image selected.');
//     }
//   }
//
//   bool _isLoading = false;
//   bool _isUploaded = false;
//
//   bool get isLoading => _isLoading;
//   bool get isUploaded => _isUploaded;
//
//   String title = '';
//   String description = '';
//   String price = '';
//   String tags = '';
//   String categoryId = '';
//   String location = '';
//   String expiresAt = '';
//
//   void setTitle(String value) {
//     title = value;
//     notifyListeners();
//   }
//
//   void setDescription(String value) {
//     description = value;
//     notifyListeners();
//   }
//
//   void setPrice(String value) {
//     price = value;
//     notifyListeners();
//   }
//
//   void setTags(String value) {
//     tags = value;
//     notifyListeners();
//   }
//
//   void setCategoryId(String value) {
//     categoryId = value;
//     notifyListeners();
//   }
//
//   void setLocation(String value) {
//     location = value;
//     notifyListeners();
//   }
//
//   void setExpiresAt(String value) {
//     expiresAt = value;
//     notifyListeners();
//   }
//
//   final tokenStorage = TokenStorage();
//
//   Future<bool> createPost(
//       String title,
//       String description,
//       String price,
//       String tags,
//       String location,
//       String expiresAt,
//       ) async {
//     _isLoading = true;
//     notifyListeners();
//
//
//     debugPrint("The expire date $expiresAt");
//     final url = Uri.parse(ApiEndpoints.createPost);
//
//     try {
//       final accessToken = await tokenStorage.getToken();
//       if (accessToken == null) {
//         debugPrint('Access token not found. Cannot add item.');
//         return false;
//       }
//
//       final request = http.MultipartRequest('POST', url);
//       request.headers['Authorization'] = 'Bearer $accessToken';
//
//       request.fields['type'] = _selectedOption;
//       request.fields['title'] = title;
//       request.fields['description'] = description;
//       request.fields['price'] = price;
//       request.fields['tags'] = tags;
//       request.fields['categoryId'] = _subSelectedOptionId;
//       request.fields['location'] = location;
//       request.fields['expiresAt'] = expiresAt;
//       request.fields['allow_chat_only'] = _allowChatOnly.toString();
//       request.fields['show_chat_info'] = _showChatInfo.toString();
//
//       if (image != null) {
//         debugPrint('Uploading image...');
//         String? mimeType = lookupMimeType(image!.path);
//         String filename = path.basename(image!.path);
//         request.files.add(
//           await http.MultipartFile.fromPath(
//             'thumbnail',
//             image!.path,
//             filename: filename,
//             contentType: mimeType != null ? MediaType.parse(mimeType) : null,
//           ),
//         );
//       } else {
//         debugPrint('No image selected to upload.');
//       }
//
//       debugPrint('Selected Option: $_selectedOption');
//       debugPrint('Selected Option Id: $_selectedOptionId');
//       debugPrint('Sub Selected Option: $_subSelectedOption');
//       debugPrint('Sub Selected Option Id: $_subSelectedOptionId');
//
//       final response = await request.send();
//       final responseBody = await response.stream.bytesToString();
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         debugPrint('Create post successfully. Status: ${response.statusCode}');
//         debugPrint('Response Body: $responseBody');
//         _isLoading = false;
//         _isUploaded = true;
//         selectOption(_selectedOption);
//         selectOptionId(_selectedOptionId);
//         subSelectOption(_subSelectedOption);
//         subSelectOptionId(_subSelectedOptionId);
//         setTitle(title);
//         setDescription(description);
//         setLocation(location);
//         setPrice(price);
//         setTags(tags);
//         setCategoryId(categoryId);
//         setExpiresAt(expiresAt);
//         notifyListeners();
//         if (responseBody.contains('message')) {
//           final Map<String, dynamic> jsonData = jsonDecode(responseBody);
//           final String onlyMessage = jsonData['message'];
//           setMessage(onlyMessage);
//           print(responseBody);
//           return false;
//         } else {
//           return true;
//         }
//       } else {
//         debugPrint('Failed to add details. Status: ${response.statusCode}');
//         debugPrint('Request URL: ${request.url}');
//         debugPrint('Request Headers: ${request.headers}');
//         debugPrint('Request Fields: ${request.fields}');
//         debugPrint('Response Body: $responseBody');
//         _isLoading = false;
//         _isUploaded = false;
//         notifyListeners();
//         return false;
//       }
//     } catch (error) {
//       debugPrint('Error adding details: $error');
//       _isLoading = false;
//       _isUploaded = false;
//       notifyListeners();
//       return false;
//     }
//   }
// }