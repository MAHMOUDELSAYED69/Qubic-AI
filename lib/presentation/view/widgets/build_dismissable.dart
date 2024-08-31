
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';

import '../../../core/model/hive.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/constants/routes.dart';
import '../../viewmodel/chat/chat_bloc.dart';
import '../../viewmodel/validation/validation_cubit.dart';

class BuildDismissibleCard extends StatelessWidget {
  const BuildDismissibleCard({
    super.key,
    required this.session,
    required ChatAIBloc chatAIBloc,
    required this.chatMessages,
    required ValidationCubit validationCubit,
    required this.index,
    required this.chatSessions,
  })  : _chatAIBloc = chatAIBloc,
        _validationCubit = validationCubit;

  final ChatSession session;
  final ChatAIBloc _chatAIBloc;
  final List<Message> chatMessages;
  final ValidationCubit _validationCubit;
  final int index;
  final List<ChatSession> chatSessions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Dismissible(
        key: ValueKey(session.chatId.toString()),
        onDismissed: (_) {
          _chatAIBloc.add(DeleteChatSessionEvent(session.chatId));
          chatSessions.removeAt(index);
        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: ColorManager.purple,
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20.w),
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.delete),
              SizedBox(width: 2.w),
              Text("Delete",
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        child: chatMessages.lastOrNull?.message != null
            ? Card(
                elevation: 0,
                margin: EdgeInsets.zero,
                surfaceTintColor: ColorManager.transparent,
                shape: const BeveledRectangleBorder(),
                child: ListTile(
                  splashColor: ColorManager.purple,
                  title: Text(
                    chatMessages.last.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                      "Started on ${_validationCubit.formatDateTime(session.createdAt)}"),
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteManager.chat,
                    arguments: [session.chatId, _chatAIBloc],
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
