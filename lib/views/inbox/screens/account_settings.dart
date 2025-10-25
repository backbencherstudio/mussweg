import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mussweg/view_model/auth/login/get_me_viewmodel.dart';
import 'package:mussweg/view_model/profile/update_profile/update_profile_details_provider.dart';
import 'package:mussweg/views/auth/sign_up/widgets/buttons.dart';
import 'package:mussweg/views/widgets/simple_apppbar.dart';
import 'package:provider/provider.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

enum FieldType { text, date, dropdown }

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();

  String? selectedGender;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetMeViewmodel>(
      builder: (context, getMeProvider, _) {
        final userdata = getMeProvider.user;

        if (userdata == null) {
          // Show loading spinner while fetching user data
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Populate controllers safely (so rebuilds don’t overwrite user typing)
        _nameController.text = userdata.name ?? "";
        _emailController.text = userdata.email ?? "";
        _locationController.text = userdata.address ?? "";
        _genderController.text = userdata.gender ?? "";
        selectedGender = userdata.gender;
        _dobController.text = userdata.dateOfBirth != null
            ? DateFormat('yyyy-MM-dd')
            .format(DateTime.parse(userdata.dateOfBirth!))
            : '';

        return Scaffold(
          appBar: SimpleApppbar(title: 'Account Settings'),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0.r),
                      side: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5.w,
                      ),
                    ),
                    child: Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
                      child: Column(
                        spacing: 12.h,
                        children: [
                          _buildField(
                            title: 'Full Name',
                            controller: _nameController,
                            hint: 'Enter your full name',
                            isReadOnly: false,
                            type: FieldType.text,
                          ),
                          _buildField(
                            title: 'Email Address',
                            controller: _emailController,
                            hint: 'Your email address',
                            isReadOnly: true,
                            type: FieldType.text,
                          ),
                          _buildField(
                            title: 'Location',
                            controller: _locationController,
                            hint: 'Enter your location/address',
                            isReadOnly: false,
                            type: FieldType.text,
                          ),
                          _buildField(
                            title: 'Gender',
                            controller: _genderController,
                            hint: 'Select gender',
                            isReadOnly: false,
                            type: FieldType.dropdown,
                            dropdownItems: ['Male', 'Female', 'Other'],
                          ),
                          _buildField(
                            title: 'Date Of Birth',
                            controller: _dobController,
                            hint: 'Pick your birth date',
                            isReadOnly: false,
                            type: FieldType.date,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  /// Update Button + Loader
                  Consumer<UpdateProfileDetailsProvider>(
                    builder: (_, updateProvider, __) {
                      return Visibility(
                        visible: !updateProvider.isLoading,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: PrimaryButton(
                          onTap: () async {
                            final fullName = _nameController.text.trim();
                            final location = _locationController.text.trim();
                            final gender = _genderController.text.trim();
                            final dob = _dobController.text.trim();

                            final res = await updateProvider.updateProfile(
                              fullName,
                              location,
                              gender,
                              dob,
                            );

                            if (res) {
                              await context.read<GetMeViewmodel>().fetchUserData();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                  Text('Profile updated successfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    updateProvider.message ?? "Something went wrong",
                                  ),
                                ),
                              );
                            }
                          },
                          title: 'Update',
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// --- FIELD BUILDER ---
  Widget _buildField({
    required String hint,
    required String title,
    required TextEditingController controller,
    required bool isReadOnly,
    FieldType type = FieldType.text,
    List<String>? dropdownItems,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: const Color(0xff4A4C56),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              if (type != FieldType.dropdown)
                Image.asset('assets/icons/edit_text.png', scale: 3.w),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        _buildFieldByType(
          type: type,
          controller: controller,
          hint: hint,
          isReadOnly: isReadOnly,
          dropdownItems: dropdownItems,
        ),
        SizedBox(height: 4.h),
        const Divider(),
      ],
    );
  }

  /// --- FIELD TYPE HANDLER ---
  Widget _buildFieldByType({
    required FieldType type,
    required TextEditingController controller,
    required String hint,
    required bool isReadOnly,
    List<String>? dropdownItems,
  }) {
    switch (type) {
      case FieldType.text:
        return TextField(
          controller: controller,
          readOnly: isReadOnly,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        );

      case FieldType.date:
        return TextField(
          controller: controller,
          readOnly: true,
          onTap: () async {
            FocusScope.of(context).requestFocus(FocusNode());

            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      onSurface: Colors.black,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );

            if (pickedDate != null) {
              controller.text =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
            }
          },
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: Icon(
              Icons.calendar_month_outlined,
              color: Colors.grey.shade500,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        );

      case FieldType.dropdown:
        return DropdownButtonFormField<String>(
          value: selectedGender != null &&
              dropdownItems?.contains(selectedGender) == true
              ? selectedGender
              : null,
          dropdownColor: Colors.white,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
          hint: Text(hint),
          items: dropdownItems
              ?.map((item) => DropdownMenuItem(
            value: item,
            child: Text(item),
          ))
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedGender = value;
              controller.text = value ?? '';
            });
          },
        );
    }
  }
}
