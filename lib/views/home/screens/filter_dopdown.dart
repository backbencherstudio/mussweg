import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../view_model/profile/sell_item_service_provider/sell_item_service.dart';
import '../../profile/widgets/custom_dropdown_field.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  RangeValues _priceRange = const RangeValues(20, 80);
  final List<String> _categories = [
    'Dress',
    'Shoes',
    'Bag',
    'Makeup',
    'Sunglass',
    'Men Clothes',
    'Woman Clothes',
  ];
  final List<String> _conditions = const [
    "New",
    "Used",
    "Refurbished",
  ];
  final List<String> _times = ['12hr', '20hr', '24hr', '30hr', '40hr', '48hr'];
  final service = GetIt.instance<SellItemService>();

  String? _selectedCategory;
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildSectionTitle('Price Range'),
            _buildPriceSlider(),
            _buildSectionTitle('Categories'),
            _buildChipRow(_categories, _selectedCategory, (chip) {
              setState(() {
                _selectedCategory = chip;
              });
            }),
            _buildSectionTitle('Time'),
            _buildChipRow(_times, _selectedTime, (chip) {
              setState(() {
                _selectedTime = chip;
              });
            }),
            CustomDropdownField(
              title: 'Location',
              hintText: 'St.Gallen & Eastern Switzerland',
              items: _conditions,
              value: service.categoryId,
              onChanged: (value) {
                service.setCategoryId(value ?? '');
              }
            ),
            _buildCustomLocation(),
            const SizedBox(height: 20),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Filters',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Text(
      title,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    ),
  );

  Widget _buildPriceSlider() {
    return Column(
      children: [
        RangeSlider(
          values: _priceRange,
          min: 0,
          max: 200,
          divisions: 100,
          labels: RangeLabels(
            '\$${_priceRange.start.round()}',
            '\$${_priceRange.end.round()}',
          ),
          activeColor: Colors.red,
          onChanged: (RangeValues values) {
            setState(() {
              _priceRange = values;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('\$${_priceRange.start.round()}'),
            Text('\$${_priceRange.end.round()}'),
          ],
        ),
      ],
    );
  }

  Widget _buildChipRow(
      List<String> items,
      String? selected,
      Function(String) onSelected,
      ) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: items.map((chip) {
        return FilterChip(
          label: Text(chip),
          selected: selected == chip,
          selectedColor: Colors.red[100],
          checkmarkColor: Colors.red,
          labelStyle: TextStyle(
            color: selected == chip ? Colors.red : Colors.grey,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: selected == chip ? Colors.red : Colors.grey,
            ),
          ),
          backgroundColor: Colors.transparent,
          onSelected: (_) => onSelected(chip),
        );
      }).toList(),
    );
  }

  Widget _buildCustomLocation() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: const [
          Icon(Icons.add, color: Colors.red),
          SizedBox(width: 8),
          Text(
            'Custom Location',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold,fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Color(0xffF5F5F5),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              side: const BorderSide(color: Colors.grey),
            ),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Apply', style: TextStyle(color: Colors.white)),
          ),
        ),
      ],
    );
  }
}
