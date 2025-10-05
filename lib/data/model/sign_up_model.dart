class RegisterResponseModel {
  final bool success;
  final String message;
  final RegisterUserData? data;

  RegisterResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? RegisterUserData.fromJson(json['data'])
          : null,
    );
  }
}

class RegisterUserData {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? token;

  RegisterUserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.token,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) {
    return RegisterUserData(
      id: json['id'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'],
    );
  }
}
