import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';

import '../../../core/constants/api_end_points.dart';
import '../../../core/services/token_storage.dart';

class MusswegProductScreenProvider extends ChangeNotifier {
  // ---------- PRODUCT / IMAGE UPLOAD ----------
  String? _message;
  String? get message => _message;

  void setMessage(String message) {
    _message = message;
    debugPrint("The mussweg message ----- $_message");
    notifyListeners();
  }

  String _type = 'PICKUP';
  String get type => _type;

  void setType(String message) {
    _type = message;
    notifyListeners();
  }

  String _productId = '';
  String get productId => _productId;

  void setProductId(String message) {
    _productId = message;
    debugPrint("The mussweg product id $_productId");
    notifyListeners();
  }

  String _placeName = '';
  String get placeName => _placeName;

  void setPlaceName(String message) {
    _placeName = message;
    notifyListeners();
  }

  String _name = '';
  String get name => _name;

  void setName(String message) {
    _name = message;
    notifyListeners();
  }

  String _pType = '';
  String get pType => _pType;

  void setProductType(String message) {
    _pType = message;
    notifyListeners();
  }

  String _quantity = '';
  String get quantity => _quantity;

  void setQuantity(String message) {
    _quantity = message;
    notifyListeners();
  }

  final ImagePicker _picker = ImagePicker();
  File? _image;
  File? get image => _image;

  bool _isLoading = false;
  bool _isUploaded = false;

  bool get isLoading => _isLoading;
  bool get isUploaded => _isUploaded;

  final tokenStorage = TokenStorage();

  Future<void> pickSingleImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final tempFile = File(pickedFile.path);
      final appDir = await getApplicationDocumentsDirectory();

      final savedImage = await tempFile.copy(
        '${appDir.path}/picked_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      _image = savedImage;

      debugPrint('Saved image at: ${_image!.path}');
      notifyListeners();
    } else {
      debugPrint('No image selected.');
    }
  }

  Future<bool> createMusswegForPickup({required String placeAddress}) async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.createMusswegDisposal(_productId));

    try {
      final accessToken = await tokenStorage.getToken();
      if (accessToken == null) {
        debugPrint('Access token not found. Cannot add item.');
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $accessToken';

      // TEXT FIELDS
      request.fields['productname'] = _name;
      request.fields['producttype'] = _pType;
      request.fields['productquantity'] = _quantity;
      request.fields['type'] = _type;
      request.fields['place_name'] = _placeName;
      request.fields['place_address'] = placeAddress;
      request.fields['place_latitude'] = _selectedLocation.latitude.toString();
      request.fields['place_longitude'] =
          _selectedLocation.longitude.toString();

      debugPrint("The mussweg type $_type");
      debugPrint("The mussweg place name $_placeName");
      debugPrint("The mussweg place address $placeAddress");
      debugPrint("The mussweg product name $_name");
      debugPrint("The mussweg product type $_pType");
      debugPrint("The mussweg product quantity $_quantity");
      debugPrint("The mussweg latitude ${_selectedLocation.latitude}");
      debugPrint("The mussweg longitude ${_selectedLocation.longitude}");

      // IMAGE FILE
      if (_image != null) {
        final mimeType = lookupMimeType(_image!.path);
        final filename = path.basename(_image!.path);

        request.files.add(
          await http.MultipartFile.fromPath(
            'images',
            _image!.path,
            filename: filename,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );

        debugPrint('Uploading image: $filename');
      } else {
        debugPrint('No image selected to upload.');
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _isLoading = false;

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 409) {
        final responseMap = jsonDecode(responseBody);

        _isUploaded = true;

        if (responseMap.toString().contains('409')) {
          setMessage(responseMap['message']['message']);
          debugPrint('======= Boom ======');
        } else {
          setMessage(responseMap['message']);
        }

        notifyListeners();
        return responseMap['success'] ?? false;
      } else {
        debugPrint('Failed to create post. Status: ${response.statusCode}');
        final responseMap = jsonDecode(responseBody);
        setMessage(responseMap['message']['message']);
        debugPrint('Failed to create post. Status: $responseBody');
        _isUploaded = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      debugPrint('Error creating post: $error');
      if (error.toString().contains('409')) {
        setMessage(
          'A disposal request for this product is already in progress.',
        );
      }
      _isLoading = false;
      _isUploaded = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> createMusswegForSendIn() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(ApiEndpoints.createMusswegDisposal(_productId));

    try {
      final accessToken = await tokenStorage.getToken();
      if (accessToken == null) {
        debugPrint('Access token not found. Cannot add item.');
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $accessToken';

      // TEXT FIELDS
      request.fields['productname'] = _name;
      request.fields['producttype'] = _pType;
      request.fields['productquantity'] = _quantity;
      request.fields['type'] = _type;

      // IMAGE FILE
      if (_image != null) {
        final mimeType = lookupMimeType(_image!.path);
        final filename = path.basename(_image!.path);

        request.files.add(
          await http.MultipartFile.fromPath(
            'images',
            _image!.path,
            filename: filename,
            contentType: mimeType != null ? MediaType.parse(mimeType) : null,
          ),
        );

        debugPrint('Uploading image: $filename');
      } else {
        debugPrint('No image selected to upload.');
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      _isLoading = false;

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 409) {
        final responseMap = jsonDecode(responseBody);

        _isUploaded = true;

        if (responseBody.contains('409')) {
          setMessage(responseMap['message']['message']);
        } else {
          setMessage(responseMap['message']);
        }

        debugPrint("The mussweg message ---11-- $_message");

        notifyListeners();
        return responseMap['success'] ?? false;
      } else {
        debugPrint('Failed to create post. Status: ${response.statusCode}');
        final responseMap = jsonDecode(responseBody);
        setMessage(responseMap['message']['message']);
        debugPrint('Failed to create post. Status: $responseBody');
        _isUploaded = false;
        notifyListeners();
        return false;
      }
    } catch (error) {
      debugPrint('Error creating post: $error');
      if (error.toString().contains('409')) {
        setMessage(
          'A disposal request for this product is already in progress.',
        );
      }
      _isLoading = false;
      _isUploaded = false;
      notifyListeners();
      return false;
    }
  }

  // ---------- LOCATION / ADDRESS ----------
  LatLng _selectedLocation = LatLng(47.37445, 8.54104);
  List<dynamic> _searchResults = [];
  String _currentAddress = "";
  final TextEditingController searchController = TextEditingController();

  LatLng get selectedLocation => _selectedLocation;
  List<dynamic> get searchResults => _searchResults;
  String get currentAddress => _currentAddress;

  void setSelectedLocation(LatLng location) {
    _selectedLocation = location;
    notifyListeners();
  }

  Future<String> getAddressFromLatLng(LatLng position) async {
    final url =
        "https://nominatim.openstreetmap.org/reverse?format=json"
        "&lat=${position.latitude}"
        "&lon=${position.longitude}"
        "&zoom=18"
        "&addressdetails=1"
        "&accept-language=en";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "Flutter App"},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data["display_name"] ?? "Unknown location";
      }
    } catch (e) {
      debugPrint("Reverse geocoding failed: $e");
    }

    return "Address not found";
  }

  Future<void> fetchAndStoreAddress() async {
    _currentAddress = await getAddressFromLatLng(_selectedLocation);
    debugPrint("Selected Address: $_currentAddress");
    notifyListeners();
  }

  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    final url =
        "https://nominatim.openstreetmap.org/search?format=json"
        "&addressdetails=1"
        "&limit=5"
        "&accept-language=en"
        "&q=$query";

    try {
      final res = await http.get(
        Uri.parse(url),
        headers: {"User-Agent": "Flutter App"},
      );

      if (res.statusCode == 200) {
        _searchResults = json.decode(res.body);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Search failed: $e");
      _searchResults = [];
      notifyListeners();
    }
  }

  void selectSearchResult(dynamic place) {
    final lat = double.parse(place["lat"]);
    final lon = double.parse(place["lon"]);
    _selectedLocation = LatLng(lat, lon);
    _searchResults = [];
    searchController.text = place["display_name"];
    notifyListeners();
  }
}
