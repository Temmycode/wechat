import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? username;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final DateTime? dateOfBirth;

  const UserEntity(
    this.id,
    this.username,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.dateOfBirth,
  );

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
}
