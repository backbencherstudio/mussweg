// lib/views/screens/language_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../view_model/language/language_provider.dart';
import '../../../widgets/custom_button.dart';
import '../../widgets/simple_apppbar.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String? _selectedLanguage;
  bool _isChangingLanguage = false;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = context.read<LanguageProvider>().currentLang;
  }

  Future<void> _changeLanguage(BuildContext context, String langCode) async {
    if (_isChangingLanguage || _selectedLanguage == langCode) return;

    setState(() {
      _isChangingLanguage = true;
    });

    try {
      final languageProvider = context.read<LanguageProvider>();
      await languageProvider.setLanguage(langCode);

      // Update UI
      setState(() {
        _selectedLanguage = langCode;
      });

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Language changed to ${languageProvider.getLanguageName(langCode)}',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      // Show error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to change language: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
      // Revert selection
      setState(() {
        _selectedLanguage = context.read<LanguageProvider>().currentLang;
      });
    } finally {
      setState(() {
        _isChangingLanguage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();
    final languages = languageProvider.getAllLanguages();

    return Scaffold(
      appBar: SimpleApppbar(
        title: languageProvider.translate('Language'),
        onBack: () => Navigator.pop(context),
      ),
      body: _isChangingLanguage
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              languageProvider.translate('Select Language'),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              languageProvider.translate('Choose your preferred language'),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),

            // Language search field
            _buildLanguageSearchField(languageProvider),
            SizedBox(height: 20.h),

            // Language list
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  final isSelected = _selectedLanguage == language['code'];

                  return _buildLanguageCard(
                    language: language,
                    isSelected: isSelected,
                    languageProvider: languageProvider,
                  );
                },
              ),
            ),

            // Save button
            SizedBox(height: 20.h),
            CustomButton(
              text: languageProvider.translate('Save'),
              textColor: Colors.white,
              buttonColor: const Color(0xffDE3526),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSearchField(LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: languageProvider.translate('Search language...'),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageCard({
    required Map<String, String> language,
    required bool isSelected,
    required LanguageProvider languageProvider,
  }) {
    final String flagEmoji = _getFlagEmoji(language['code']!);

    return Card(
      color: Colors.white,
      elevation: isSelected ? 2 : 0,
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade200,
          width: isSelected ? 1.5.w : 0.5.w,
        ),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        leading: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: Colors.grey[100],
          ),
          child: Center(
            child: Text(
              flagEmoji,
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
        ),
        title: Text(
          language['name']!,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.blue : Colors.black87,
          ),
        ),
        subtitle: Text(
          language['code']!.toUpperCase(),
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        trailing: isSelected
            ? Icon(
          Icons.check_circle,
          color: Colors.blue,
          size: 24.w,
        )
            : null,
        onTap: () => _changeLanguage(context, language['code']!),
      ),
    );
  }

  String _getFlagEmoji(String countryCode) {
    switch (countryCode) {
      case 'en':
        return '🇬🇧';
      case 'de':
        return '🇩🇪';
      case 'fr':
        return '🇫🇷';
      case 'bn':
        return '🇧🇩';
      default:
        return '🏳️';
    }
  }
}