import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int? id;
  final String? username;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? password;
  final DateTime? dateOfBirth;

  const UserModel({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.firstName,
    required this.lastName,
    required this.imageUrl,
    required this.password,
    required this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    phoneNumber,
    firstName,
    lastName,
    imageUrl,
    dateOfBirth,
  ];

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      imageUrl: json['image_url'] ?? "",
      password: '',
      dateOfBirth: DateTime.parse(json['date_of_birth']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageUrl,
      'password': password,
      'date_of_birth': dateOfBirth,
    };
  }
}
