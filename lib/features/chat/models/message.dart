// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:wechat/core/utils/equatable_date_time.dart';
import 'package:wechat/features/auth/models/user.dart';

part 'message.g.dart';

@HiveType(typeId: 1)
class MessageModel extends HiveObject with EquatableMixin {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final int senderId;
  @HiveField(2)
  final int conversationId;
  @HiveField(3)
  final String content;
  @HiveField(4)
  final EquatableDateTime timestamp;
  @HiveField(5)
  final UserModel sender;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.conversationId,
    required this.content,
    required this.timestamp,
    required this.sender,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as int,
      senderId: json['sender_id'] as int,
      conversationId: json['conversation_id'] as int,
      content: json['content'] as String,
      timestamp:
          json['timestamp'] != null
              ? EquatableDateTime.fromDateTime(
                DateTime.parse(json['timestamp']),
              )
              : EquatableDateTime.fromDateTime(DateTime.now()),
      sender: UserModel.fromMap(json['sender']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    senderId,
    conversationId,
    content,
    timestamp,
    sender,
  ];

  MessageModel copyWith({
    int? id,
    int? senderId,
    int? conversationId,
    String? content,
    EquatableDateTime? timestamp,
    UserModel? sender,
  }) {
    return MessageModel(
      id: id ?? this.id,
      senderId: senderId ?? this.senderId,
      conversationId: conversationId ?? this.conversationId,
      content: content ?? this.content,
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
    );
  }
}
