import 'package:equatable/equatable.dart';
import 'package:wechat/features/auth/models/user.dart';

class MessageModel extends Equatable {
  final int id;
  final int senderId;
  final int conversationId;
  final String content;
  final DateTime timestamp;
  final UserModel sender;

  const MessageModel({
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
