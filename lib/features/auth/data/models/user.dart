import 'package:wechat/features/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    int? id,
    String? username,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? imageUrl,
    DateTime? dateOfBirth,
  }) : super(0, '', '', '', '', '', null);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      imageUrl: json['image_url'] ?? "",
      dateOfBirth: DateTime.parse(json['date_of_birth']),
    );
  }
}
