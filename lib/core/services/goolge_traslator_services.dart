// services/google_translate_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class GoogleTranslateService {
  final String apiKey = 'YOUR_GOOGLE_CLOUD_API_KEY';

  Future<String> translateText(String text, String targetLang) async {
    if (text.isEmpty) return text;

    try {
      final url = Uri.parse(
        'https://translation.googleapis.com/language/translate/v2'
        '?key=$apiKey&q=${Uri.encodeComponent(text)}&target=$targetLang',
      );

      final response = await http.post(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['translations'][0]['translatedText'];
      } else {
        debugPrint('Translation API error: ${response.statusCode}');
        return text;
      }
    } catch (e) {
      debugPrint('Translation error: $e');
      return text;
    }
  }
}
