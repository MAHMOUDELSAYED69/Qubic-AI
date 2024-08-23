import 'package:hive/hive.dart';

import '../services/database/hive.dart';

class MessageRepository {
  static final MessageRepository _instance = MessageRepository._internal();
  final Box<Message> _messageBox = Hive.box<Message>('messages');

  factory MessageRepository() {
    return _instance;
  }

  MessageRepository._internal();

  Future<void> addMessage(
      {required String uid,
      required bool isUser,
      required String message,
      required String timestamp}) async {
    await _messageBox.add(Message(
        uid: uid, isUser: isUser, message: message, timestamp: timestamp));
  }

  List<Message> getMessages() {
    return _messageBox.values.toList();
  }

  Future<void> clearMessages() async {
    await _messageBox.clear();
  }
}
