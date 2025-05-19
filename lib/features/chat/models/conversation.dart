import 'package:equatable/equatable.dart';
import 'package:wechat/core/utils/equatable_date_time.dart';
import 'package:wechat/features/auth/models/user.dart';

class ConversationModel extends Equatable {
  final int? id;
  final bool? isGroup;
  final String? name;
  final EquatableDateTime? lastMessageAt;
  final List<UserModel?>? conversationMembers;

  const ConversationModel({
    this.id,
    this.isGroup,
    this.name,
    this.lastMessageAt,
    this.conversationMembers,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['id'] as int,
      isGroup: json['is_group'] as bool,
      name: json['name'],
      lastMessageAt:
          json['last_message_at'] != null
              ? EquatableDateTime.fromDateTime(
                DateTime.parse(json['last_message_at']),
              )
              : null,
      conversationMembers: json['conversation_members'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    isGroup,
    name,
    lastMessageAt,
    conversationMembers,
  ];
}
