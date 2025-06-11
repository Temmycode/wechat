// Custom class for handling the issues with the EquatableDateTime conversion

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'message.dart';

class MessageModelCustomAdapter extends TypeAdapter<MessageModel> {
  @override
  final int typeId = 1;

  @override
  MessageModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    // Handle the DateTime to EquatableDateTime conversion
    EquatableDateTime? timestamp;
    if (fields[4] != null) {
      if (fields[4] is DateTime) {
        timestamp = EquatableDateTime.fromDateTime(fields[4] as DateTime);
      } else if (fields[4] is EquatableDateTime) {
        timestamp = fields[4] as EquatableDateTime;
      }
    } else {
      debugPrint("Wahala ti wa");
      timestamp = EquatableDateTime.fromDateTime(DateTime.now());
    }

    return MessageModel(
      id: fields[0] as int,
      senderId: fields[1] as int,
      conversationId: fields[2] as int,
      content: fields[3] as String,
      timestamp: timestamp!,
      sender: fields[5] as UserModel,
    );
  }

  @override
  void write(BinaryWriter writer, MessageModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.senderId)
      ..writeByte(2)
      ..write(obj.conversationId)
      ..writeByte(3)
      ..write(obj.content)
      ..writeByte(4)
      ..write(obj.timestamp)
      ..writeByte(5)
      ..write(obj.sender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageModelCustomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
