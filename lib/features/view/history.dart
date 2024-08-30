import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubic_ai/core/di/get_it.dart';
import 'package:qubic_ai/features/viewmodel/chat/chat_bloc.dart';
import 'package:qubic_ai/features/widgets/empty_body.dart';
import '../../core/utils/constants/images.dart';
import '../viewmodel/validation/validation_cubit.dart';
import '../widgets/build_dismissable.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({super.key});

  final _chatAIBloc = getIt<ChatAIBloc>();
  final _validationCubit = getIt<ValidationCubit>();
  @override
  Widget build(BuildContext context) {
    final chatSessions = _chatAIBloc.getChatSessions();

    return BlocBuilder<ChatAIBloc, ChatAIState>(
      bloc: _chatAIBloc,
      builder: (context, state) {
        return Scaffold(
          body: chatSessions.length <= 1
              ? const EmptyBodyCard(
                  title: "No chat history available.",
                  image: ImageManager.history)
              : ListView.builder(
                  itemCount: chatSessions.length,
                  itemBuilder: (context, index) {
                    final session = chatSessions[index];
                    final chatMessages =
                        _chatAIBloc.getMessages(session.chatId);
                    return BuildDismissibleCard(
                        index: index,
                        chatSessions: chatSessions,
                        session: session,
                        chatAIBloc: _chatAIBloc,
                        chatMessages: chatMessages,
                        validationCubit: _validationCubit);
                  },
                ),
        );
      },
    );
  }
}
