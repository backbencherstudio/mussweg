import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/api_end_points.dart';
import '../../../core/services/token_storage.dart';

class SellerProfileProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  final tokenStorage = TokenStorage();

  File? profileImage;
  bool _isUploading = false;
  String? _uploadMessage;

  bool get isUploading => _isUploading;
  String? get uploadMessage => _uploadMessage;

  Future<void> pickProfileImage() async {         //profile picture pick korbo
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      profileImage = File(picked.path);
      notifyListeners();
    }
  }

  Future<bool> uploadProfileImage() async {       //selected picture upload korbo
    if (profileImage == null) {
      debugPrint("No image selected for upload.");
      return false;
    }

    _isUploading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.updateProfile);
    try {
      final accessToken = await tokenStorage.getToken();
      if (accessToken == null) {
        debugPrint("Access token missing.");
        return false;
      }

      final request = http.MultipartRequest('PATCH', url);
      request.headers['Authorization'] = 'Bearer $accessToken';

      final mimeType = lookupMimeType(profileImage!.path);
      final filename = path.basename(profileImage!.path);

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        profileImage!.path,
        filename: filename,
        contentType: mimeType != null ? MediaType.parse(mimeType) : null,
      ));

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(responseBody);
        _uploadMessage = data['message'] ?? 'Profile updated successfully.';
        _isUploading = false;
        notifyListeners();
        return true;
      } else {
        debugPrint("Upload failed?? ${response.statusCode}");
        debugPrint(responseBody);
        _isUploading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      debugPrint("Error uploading image: $e");
      _isUploading = false;
      notifyListeners();
      return false;
    }
  }
}