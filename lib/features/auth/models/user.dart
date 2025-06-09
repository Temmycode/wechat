import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? username;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? phoneNumber;
  @HiveField(4)
  final String? firstName;
  @HiveField(5)
  final String? lastName;
  @HiveField(6)
  final String? mantra;
  @HiveField(7)
  final String? imageUrl;
  @HiveField(8)
  final String? password;
  @HiveField(9)
  final EquatableDateTime? dateOfBirth;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.mantra,
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
    mantra,
    password,
    imageUrl,
    dateOfBirth,
  ];

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] is int ? json['id'] : null,
      username: json['username'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      mantra: json['mantra'],
      imageUrl: json['image_url'],
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
      'id': id,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageUrl,
      'mantra': mantra,
      'date_of_birth': dateOfBirth?.toIso8601String(),
    };
  }

  Map<String, dynamic> createUser() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone_number': phoneNumber,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageUrl,
      'mantra': mantra,
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
