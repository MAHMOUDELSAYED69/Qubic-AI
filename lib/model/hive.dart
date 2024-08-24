import 'package:hive_flutter/hive_flutter.dart';
part 'hive.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final int chatId;
  @HiveField(1)
  final bool isUser;
  @HiveField(2)
  final String message;
  @HiveField(3)
  final String timestamp;

  Message({
    required this.chatId,
    required this.isUser,
    required this.message,
    required this.timestamp,
  });
}

@HiveType(typeId: 1)
class ChatSession extends HiveObject {
  @HiveField(0)
  late final int chatId ;
  @HiveField(1)
  final String createdAt;
  @HiveField(2)
  final List<Message> messages; 

  ChatSession({
    required this.chatId,
    required this.createdAt,
    this.messages = const [],
  });

  int get messageCount => messages.length; 
}
