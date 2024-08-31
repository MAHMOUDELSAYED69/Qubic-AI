part of 'chat_bloc.dart';

@immutable
abstract class ChatAIEvent {}

class PostDataEvent extends ChatAIEvent {
  final String prompt;
  final int chatId;
  final bool isUser;

  PostDataEvent({
    required this.prompt,
    required this.chatId,
    required this.isUser,
  });
}

class StreamDataEvent extends ChatAIEvent {
  final String prompt;
  final int chatId;
  final bool isUser;

  StreamDataEvent({
    required this.prompt,
    required this.chatId,
    required this.isUser,
  });
}

class CreateNewChatSessionEvent extends ChatAIEvent {}

class LoadAIChatEvent extends ChatAIEvent {}

class DeleteChatSessionEvent extends ChatAIEvent {
  final int chatId;

  DeleteChatSessionEvent(this.chatId);
}
