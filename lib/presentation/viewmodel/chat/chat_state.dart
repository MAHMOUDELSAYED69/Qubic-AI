part of 'chat_bloc.dart';

@immutable
abstract class ChatAIState {}

class ChatAIInitial extends ChatAIState {}

class ChatAILoading extends ChatAIState {}

class ChatAISuccess extends ChatAIState {
  final String response;

  ChatAISuccess(this.response);
}

class ChatAIStreaming extends ChatAIState {
  final String streamedText;

  ChatAIStreaming(this.streamedText);
}

class ChatAIFailure extends ChatAIState {
  final String error;

  ChatAIFailure(this.error);
}

class NewChatSessionCreated extends ChatAIState {
  final int newChatId;

  NewChatSessionCreated(this.newChatId);
}

class ChatSessionsLoaded extends ChatAIState {
  final List<ChatSession> sessions;

  ChatSessionsLoaded(this.sessions);
}

class ChatSessionsEmpty extends ChatAIState {}

class ChatSessionDeleted extends ChatAIState {
  final int chatId;

  ChatSessionDeleted(this.chatId);
}

class ChatSessionAIFailure extends ChatAIState {
  final String error;
  ChatSessionAIFailure(this.error);
}
