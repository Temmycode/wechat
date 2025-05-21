import 'package:equatable/equatable.dart';
import 'package:wechat/features/auth/models/user.dart';
import 'package:wechat/features/chat/models/conversation.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final List<ConversationModel> allConversations;
  final List<UserModel> contactUsers;
  final String? error;

  const ChatState({
    required this.isLoading,
    required this.allConversations,
    required this.error,
    required this.contactUsers,
  });

  ChatState.unknown()
    : isLoading = false,
      allConversations = [],
      contactUsers = [],
      error = null;

  @override
  List<Object?> get props => [isLoading, allConversations, contactUsers, error];

  ChatState copyWith({
    bool? isLoading,
    List<ConversationModel>? allConversations,
    List<UserModel>? contactUsers,
    String? error,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      allConversations: allConversations ?? this.allConversations,
      contactUsers: contactUsers ?? this.contactUsers,
      error: error ?? this.error,
    );
  }
}
