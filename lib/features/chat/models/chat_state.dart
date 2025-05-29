import 'package:equatable/equatable.dart';
import 'package:wechat/features/chat/models/conversation.dart';

class ChatState extends Equatable {
  final bool isLoading;
  final List<ConversationModel> allConversations;
  final String? error;

  const ChatState({
    required this.isLoading,
    required this.allConversations,
    required this.error,
  });

  ChatState.unknown() : isLoading = false, allConversations = [], error = null;

  @override
  List<Object?> get props => [isLoading, allConversations, error];

  ChatState copyWith({
    bool? isLoading,
    List<ConversationModel>? allConversations,
    String? error,
  }) {
    return ChatState(
      isLoading: isLoading ?? this.isLoading,
      allConversations: allConversations ?? this.allConversations,
      error: error ?? this.error,
    );
  }
}
