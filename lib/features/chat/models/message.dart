import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wechat/features/auth/models/user.dart';

// TODO: fix the issues with the message model into hive custom type

@HiveType(typeId: 0)
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
  final DateTime timestamp;
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
              ? DateTime.parse(json['timestamp'])
              : DateTime.now(),
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
}
