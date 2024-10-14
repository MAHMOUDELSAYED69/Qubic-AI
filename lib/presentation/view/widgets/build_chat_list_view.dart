import 'package:flutter/material.dart';

import '../../../core/model/hive.dart';
import '../../viewmodel/chat/chat_bloc.dart';
import 'bubble.dart';

class BuildChatListViewBuilder extends StatelessWidget {
  const BuildChatListViewBuilder({
    super.key,
    required ScrollController scrollController,
    required this.messagesLength,
    required this.prompt,
    required this.messages,
    required this.state,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final int messagesLength;
  final String prompt;
  final List<Message> messages;
  final ChatAIState state;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      itemCount: messagesLength,
      itemBuilder: (context, index) {
        if (state is ChatAIStreaming && index == 0) {
          return AiBubble(
            message: prompt.trim(),
            time: DateTime.now().toString(),
          );
        } else {
          final adjustedIndex = state is ChatAIStreaming ? index - 1 : index;
          final message = messages[adjustedIndex];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: message.isUser
                ? UserBubble(
                    message: message.message.trim(),
                    time: message.timestamp,
                  )
                : AiBubble(
                    message: message.message.trim(),
                    time: message.timestamp,
                  ),
          );
        }
      },
    );
  }
}
