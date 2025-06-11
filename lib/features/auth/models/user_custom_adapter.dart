// Custom class for handling the issues with the EquatableDateTime conversion

import 'package:hive/hive.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';
import 'user.dart';

class UserModelCustomAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Handle the DateTime to EquatableDateTime conversion
    EquatableDateTime? dateOfBirth;
    if (fields[9] != null) {
      if (fields[9] is DateTime) {
        dateOfBirth = EquatableDateTime.fromDateTime(fields[9] as DateTime);
      } else if (fields[9] is EquatableDateTime) {
        dateOfBirth = fields[9] as EquatableDateTime;
      }
    }

    return UserModel(
      id: fields[0] as int?,
      username: fields[1] as String?,
      email: fields[2] as String?,
      phoneNumber: fields[3] as String?,
      firstName: fields[4] as String?,
      lastName: fields[5] as String?,
      mantra: fields[6] as String?,
      imageUrl: fields[7] as String?,
      password: fields[8] as String?,
      dateOfBirth: dateOfBirth,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.phoneNumber)
      ..writeByte(4)
      ..write(obj.firstName)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.mantra)
      ..writeByte(7)
      ..write(obj.imageUrl)
      ..writeByte(8)
      ..write(obj.password)
      ..writeByte(9)
      ..write(obj.dateOfBirth);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelCustomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
