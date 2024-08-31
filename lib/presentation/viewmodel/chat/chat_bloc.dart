import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/model/hive.dart';
import '../../../core/repositories/message_repository.dart';
import '../../../core/services/apis/genetative_ai.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatAIBloc extends Bloc<ChatAIEvent, ChatAIState> {
  final GenerativeAIWebService _webService;
  final MessageRepository _messageRepository;

  ChatAIBloc(this._webService, this._messageRepository)
      : super(ChatAIInitial()) {
    on<PostDataEvent>(_onPostData);
    on<StreamDataEvent>(_onStreamData);
    on<CreateNewChatSessionEvent>(_onCreateNewChatSession);
    on<DeleteChatSessionEvent>(_onDeleteChatSession);
  }

  Future<void> _onCreateNewChatSession(
      CreateNewChatSessionEvent event, Emitter<ChatAIState> emit) async {
    try {
      final messages = _messageRepository.getMessages(getSessionId()).toList();
      if (messages.isNotEmpty) {
        final newChatId = await _messageRepository.createNewChatSession();
        emit(NewChatSessionCreated(newChatId));
      } else {
        emit(ChatAIFailure("Failed to create new chat session"));
      }
    } catch (error) {
      emit(ChatAIFailure(
          "Failed to create new chat session: ${error.toString()}"));
    }
  }

  int getSessionId() {
    return _messageRepository.getChatSessions().last.chatId;
  }

  List<Message> getMessages(int chatId) {
    return _messageRepository.getMessages(chatId).reversed.toList();
  }

  List<ChatSession> getChatSessions() {
    return _messageRepository.getChatSessions().reversed.toList();
  }



  Future<void> _onDeleteChatSession(
      DeleteChatSessionEvent event, Emitter<ChatAIState> emit) async {
    try {
      await _messageRepository.deleteChatSession(event.chatId);
      emit(ChatSessionDeleted(event.chatId));
    } catch (error) {
      emit(ChatAIFailure("Failed to delete chat session"));
    }
  }

  Future<void> _onPostData(
      PostDataEvent event, Emitter<ChatAIState> emit) async {
    emit(ChatAILoading());
    try {
      await _messageRepository.addMessage(
        chatId: event.chatId,
        isUser: true,
        message: event.prompt,
        timestamp: DateTime.now().toString(),
      );

      final response = await _webService.postData(event.prompt);
      if (response != null) {
        await _messageRepository.addMessage(
          chatId: event.chatId,
          isUser: false,
          message: response,
          timestamp: DateTime.now().toString(),
        );
        emit(ChatAISuccess(response));
      } else {
        emit(ChatAIFailure("Failed to get a response"));
      }
    } catch (error) {
      emit(ChatAIFailure(error.toString()));
    }
  }

  Future<void> _onStreamData(
      StreamDataEvent event, Emitter<ChatAIState> emit) async {
    emit(ChatAILoading());
    final StringBuffer fullResponse = StringBuffer();

    try {
      await _messageRepository.addMessage(
        chatId: event.chatId,
        isUser: true,
        message: event.prompt,
        timestamp: DateTime.now().toString(),
      );

      await for (final chunk in _webService.streamData(event.prompt)) {
        if (chunk != null) {
          fullResponse.write(chunk);
          emit(ChatAIStreaming(chunk));
        }
      }

      final completeResponse = fullResponse.toString();
      await _messageRepository.addMessage(
        chatId: event.chatId,
        isUser: false,
        message: completeResponse,
        timestamp: DateTime.now().toString(),
      );

      emit(ChatAISuccess(completeResponse));
    } catch (error) {
      emit(ChatAIFailure("Failed to get a response from stream $error"));
    }
  }
}
