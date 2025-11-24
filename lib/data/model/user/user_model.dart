class UserResponseModel {
  final bool success;
  final UserData? data;

  const UserResponseModel({
    required this.success,
    this.data,
  });

  /// Factory constructor to create an instance from JSON
  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      success: json['success'] ?? false,
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String? avatar;
  final String? address;
  final String? phoneNumber;
  final String type;
  final String? gender;
  final String? dateOfBirth;

  String get name => '$firstName $lastName';

  const UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.avatar,
    this.address,
    this.phoneNumber,
    required this.type,
    this.gender,
    this.dateOfBirth,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'],
      address: json['address'],
      phoneNumber: json['phone_number'],
      type: json['type'] ?? '',
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
    );
  }
}
