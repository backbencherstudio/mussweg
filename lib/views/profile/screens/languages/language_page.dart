import 'package:flutter/material.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mussweg/views/widgets/custom_button.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});
  @override
  State<LanguagePage> createState() => _LanguagePageState();
}
class _LanguagePageState extends State<LanguagePage> {
  String? _selectedLanguage;

  final List<Map<String, String>> languages = [
    {'name': 'English', 'flag': 'assets/icons/english.png'},
    {'name': 'Spanish', 'flag': 'assets/icons/spanish.png'},
    {'name': 'Bangla', 'flag': 'assets/icons/bangla.png'},
    {'name': 'French', 'flag': 'assets/icons/french.png'},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleApppbar(title: 'Language'),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, size: 20.w),
                hintText: 'Search language',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView.builder(
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];
                  return Card(
                    color: Colors.white,
                    elevation: 0,
                    margin: EdgeInsets.symmetric(vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      side: BorderSide(
                        color: _selectedLanguage == language['name']
                            ? Colors.grey.shade400
                            : Colors.grey.shade200,
                        width: _selectedLanguage == language['name']
                            ? 1.5.w
                            : 0.5.w,
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: Image.asset(
                          language['flag']!,
                          fit: BoxFit.cover,
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                      title: Text(
                        language['name']!,
                        style: TextStyle(fontSize: 14.sp),
                      ),
                      trailing: Radio<String>(
                        value: language['name']!,
                        groupValue: _selectedLanguage,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedLanguage = value;
                          });
                        },
                        activeColor: Colors.grey,
                      ),
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language['name'];
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            CustomButton(
              text: 'Save',
              textColor: Colors.white,
              buttonColor: Color(0xffDE3526),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}