import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';

class UserModel extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? password;
  final EquatableDateTime? dateOfBirth;

  const UserModel({
    this.id,
    this.username,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.password,
    this.dateOfBirth,
  });

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    phoneNumber,
    firstName,
    lastName,
    imageUrl,
    dateOfBirth,
  ];

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : null,
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      imageUrl: json['image_url'] ?? "",
      password: null,
      dateOfBirth:
          json['date_of_birth'] != null
              ? EquatableDateTime.fromDateTime(
                DateTime.parse(json['date_of_birth']),
              )
              : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageUrl,
      'password': password,
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromJson(String json) {
    final decodedJson = jsonDecode(json);
    return UserModel.fromMap(decodedJson);
  }
}
