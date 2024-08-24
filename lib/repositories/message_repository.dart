import 'dart:developer';

import 'package:hive/hive.dart';

import '../model/hive.dart';

class MessageRepository {
  static final MessageRepository _instance = MessageRepository._internal();
  final Box<Message> _messageBox = Hive.box<Message>('messages');
  final Box<ChatSession> _sessionBox = Hive.box<ChatSession>('chat_sessions');

  factory MessageRepository() {
    return _instance;
  }

  MessageRepository._internal();

  Future<void> addMessage({
    required int chatId,
    required bool isUser,
    required String message,
    required String timestamp,
  }) async {
    try {
      final newMessage = Message(
        chatId: chatId,
        isUser: isUser,
        message: message,
        timestamp: timestamp,
      );
      await _messageBox.add(newMessage);

      final session =
          _sessionBox.values.firstWhere((session) => session.chatId == chatId);
      session.messages.add(newMessage);
      await session.save();
    } catch (e) {
      log(e.toString());
    }
  }

  List<Message> getMessages(int chatId) {
    return _messageBox.values
        .where((message) => message.chatId == chatId)
        .toList();
  }

  Future<void> clearMessages(int chatId) async {
    final messagesToDelete = _messageBox.values
        .where((message) => message.chatId == chatId)
        .toList();
    for (final message in messagesToDelete) {
      await message.delete();
    }

    final session =
        _sessionBox.values.firstWhere((session) => session.chatId == chatId);
    session.messages.clear();
    await session.save();
  }

  Future<int> createNewChatSession() async {
    final newChatId = _sessionBox.length + 1;
    final session = ChatSession(
      chatId: newChatId,
      createdAt: DateTime.now().toString(),
    );
    await _sessionBox.add(session);
    return newChatId;
  }

  List<ChatSession> getChatSessions() {
    if (_sessionBox.isEmpty) {
      return [
        ChatSession(
          chatId: 1,
          createdAt: DateTime.now().toString(),
        ),
      ];
    }
    return _sessionBox.values.toList();
  }

  Future<void> deleteChatSession(int chatId) async {
    final session =
        _sessionBox.values.firstWhere((session) => session.chatId == chatId);
    await session.delete();
    await clearMessages(chatId);
  }
}
