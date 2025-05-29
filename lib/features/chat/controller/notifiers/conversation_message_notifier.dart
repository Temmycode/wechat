import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wechat/core/resources/api_client.dart';
import 'package:wechat/core/resources/database_service.dart';
import 'package:wechat/features/chat/models/message.dart';

class ConversationMessageNotifier
    extends AutoDisposeFamilyAsyncNotifier<List<MessageModel>, int> {
  final ApiClient _apiClient = ApiClient();
  final DatabaseService _dbService = DatabaseService();
  Timer? _synctimer;

  // Cache for preventing duplicate sync operations
  final Set<int> _syncingConversations = {};

  @override
  Future<List<MessageModel>> build(int conversationId) async {
    // load the messages from local messages
    final localMessages = _loadMessgesFromLocalDb(conversationId);

    // start background sync without blocking the flow
    _scheduleSync(conversationId);

    return localMessages;
  }

  void addMessage(MessageModel message) {
    final currentMessages = state.value ?? [];
    // Optimistic update 🤣
    final updatedMessages = [...currentMessages, message];
    state = AsyncValue.data(updatedMessages);

    // add the message to the local database
    try {
      _dbService.addMessageToCache(message);
    } catch (err) {
      debugPrint("An error occured saving message to cache: $err");
    }
  }

  // Load messages from local database with error handling
  List<MessageModel> _loadMessgesFromLocalDb(int conversationId) {
    try {
      final messages = _dbService.getMessagesByConversationId(conversationId);
      return messages..sort((a, b) => a.timestamp.compareTo(b.timestamp));
    } catch (err) {
      debugPrint("An error occurred: $err");
      return [];
    }
  }

  Future<void> syncMessages(int conversationId, {bool force = false}) async {
    // Prevent mulitple sync operations for the same conversation
    if (_syncingConversations.contains(conversationId) && !force) {
      return;
    }

    _syncingConversations.add(conversationId);

    try {
      // Check for the connection first
      if (!await _hasConnection()) {
        debugPrint('No internet connection, skipping sync');
        return;
      }

      final localMessages = _loadMessgesFromLocalDb(conversationId);
      final lastLocalTimestamp =
          localMessages.isNotEmpty
              ? localMessages.last.timestamp
              : DateTime.fromMillisecondsSinceEpoch(0);

      // Incremental sync: only fetch messages newer than last local message
      final remoteMessages = await _fetchRemoteMessages(
        conversationId,
        since: lastLocalTimestamp,
      );

      if (remoteMessages.isEmpty) {
        return;
      }

      // Intelligent merge with conflict resolution
      final mergedMessages = _mergeMessages(localMessages, remoteMessages);

      // Update state with merged messages
      state = AsyncValue.data(mergedMessages);
    } catch (err) {
      debugPrint("Sync error for conversation $conversationId: $err");
    } finally {
      _syncingConversations.remove(conversationId);
    }
  }

  // Fetch messages from the internet
  Future<List<MessageModel>> _fetchRemoteMessages(
    int messageId, {
    DateTime? since,
    int limit = 50,
  }) async {
    try {
      final response = await _apiClient.loadConversationPreviousMessages(
        messageId,
        since: since?.millisecondsSinceEpoch,
        limit: limit,
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        final messages =
            data.map((message) => MessageModel.fromMap(message)).toList();
        return messages;
      } else {
        return [];
      }
    } catch (err) {
      debugPrint("Error fetching remote messages: ${err.toString()}");
      return [];
    }
  }

  // Message merging with deduplication and conflict resolution
  List<MessageModel> _mergeMessages(
    List<MessageModel> localMessages,
    List<MessageModel> remoteMessages,
  ) {
    // A map for message deduplication
    final Map<int, MessageModel> messageMap = {};

    // start with local messages
    for (final message in localMessages) {
      messageMap[message.id] = message;
    }

    // Add remote messages, handling the confilcts
    final List<MessageModel> newMessages = [];
    for (final message in remoteMessages) {
      final existingMessages = messageMap[message.id];

      if (existingMessages == null) {
        // add the new messages
        messageMap[message.id] = message;
        newMessages.add(message);
      } else {
        /// Conflict resolution:
        /// Using the newer timestamp from the remote server
        if (message.timestamp.isAfter(existingMessages.timestamp)) {
          messageMap[message.id] = message;
        }
      }
    }

    // Saving the new messages to our local database
    if (newMessages.isNotEmpty) {
      _dbService.addMessagesToCache(newMessages);
    }

    // return the sorted list of the merged list
    final mergedList = messageMap.values.toList();
    mergedList.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return mergedList;
  }

  void _scheduleSync(int conversationId) {
    // Cancelling the existing timer
    _synctimer?.cancel();

    // Scheduling the sync
    Future.microtask(() => syncMessages(conversationId));

    // Scheduling periodic sync: every 30 mins
    _synctimer = Timer.periodic(
      30.seconds,
      (timer) => syncMessages(conversationId),
    );
  }

  // Check to see if there is network connection
  Future<bool> _hasConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      final hasConnection =
          !connectivityResult.contains(ConnectivityResult.none);
      return hasConnection;
    } catch (err) {
      debugPrint("Error checking for connectivity: $err");
      return false;
    }
  }
}
