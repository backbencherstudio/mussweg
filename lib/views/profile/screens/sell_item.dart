import 'package:flutter/material.dart';
import 'package:mussweg/views/profile/widgets/simple_apppbar.dart';

class SellItemPage extends StatelessWidget {
  const SellItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:SimpleApppbar(title: 'Sell an Item'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Upload photos section
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  OutlinedButton.icon(
                    icon: const Icon(Icons.add_a_photo, color: Colors.red),
                    label: const Text('Upload photos', style: TextStyle(color: Colors.red)),
                    onPressed: () {
                      // Handle upload photos
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Add up to 20 photos.',style: TextStyle(color: Color(0xff929292)),),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Form fields
            Card(color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(
                  color: Color(0xffE9E9EA), // your border color
                  width: 1.5,
                ),
              ),
              elevation: 0, // remove shadow if you just want border
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: const [
                    CustomTextField(
                      title: 'Title',
                      hintText: 'e.g. Blue Pottery Vase',
                    ),
                    CustomTextField(
                      title: 'Descriptions',
                      hintText: 'e.g. Blue Pottery Vase',
                    ),
                    CustomDropdownField(
                      title: 'Location',
                      hintText: 'Select location',
                    ),
                    CustomDropdownField(
                      title: 'Category',
                      hintText: 'Select category',
                    ),
                    CustomDropdownField(
                      title: 'Size',
                      hintText: 'Select size',
                    ),
                    CustomDropdownField(
                      title: 'Color',
                      hintText: 'Select color',
                    ),
                    CustomDropdownField(
                      title: 'Conditions',
                      hintText: 'Select Condition',
                    ),
                    CustomTimeField(title: 'Time'),
                  ],
                ),
              ),
            ),


            const SizedBox(height: 20.0),

            // Sell button
            ElevatedButton(
              onPressed: () {
                // Handle sell button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text('Sell', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String title;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Color(0xffA5A5AB)),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDropdownField extends StatelessWidget {
  final String title;
  final String hintText;

  const CustomDropdownField({
    super.key,
    required this.title,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: null,
                hint: Text(hintText,style: TextStyle(color: Color(0xffA5A5AB)),),
                items: const [],
                onChanged: (String? newValue) {
                  // Handle dropdown change
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomTimeField extends StatelessWidget {
  final String title;

  const CustomTimeField({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8.0),
          TextField(
            decoration: InputDecoration(
              hintText: 'Set time',
              hintStyle: TextStyle(color: Color(0xffA5A5AB)),
              suffixIcon: const Icon(Icons.access_time,color: Color(0xff777980),),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
