import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';
import 'package:qubic_ai/features/widgets/toast.dart';

import '../../core/di/get_it.dart';
import '../../core/utils/constants/colors.dart';
import '../viewmodel/chat/chat_bloc.dart';
import '../viewmodel/validation/validation_cubit.dart';

class BuildInputField extends StatefulWidget {
  const BuildInputField(
      {super.key,
      required this.generativeAIBloc,
      required this.isLoading,
      required this.chatId,
      required this.isChatHistory});
  final ChatAIBloc generativeAIBloc;
  final bool isLoading;
  final int chatId;
  final bool isChatHistory;

  @override
  State<BuildInputField> createState() => _BuildInputFieldState();
}

class _BuildInputFieldState extends State<BuildInputField> {
  late TextEditingController _textInputFieldController;

  @override
  void initState() {
    super.initState();
    _textInputFieldController = TextEditingController();
  }

  void _sendMessage() {
    if (_textInputFieldController.text.trim().isNotEmpty) {
      widget.generativeAIBloc.add(
        StreamDataEvent(
          prompt: _textInputFieldController.text.trim(),
          isUser: true,
          chatId: widget.chatId,
        ),
      );
      _textInputFieldController.clear();
    }
    setState(() {});
  }

  final _validationCubit = getIt<ValidationCubit>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: TextField(
        minLines: 1,
        maxLines: 4,
        onChanged: (text) {
          if (text.trim().length == 1 || text.trim().isEmpty) {
            setState(() {});
          }
        },
        style: context.textTheme.bodyMedium,
        controller: _textInputFieldController,
        textDirection:
            _validationCubit.getFieldDirection(_textInputFieldController.text),
        onSubmitted: (_) => _sendMessage(),
        decoration: InputDecoration(
          hintText: 'Write Your Message..',
          suffixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: widget.isLoading
                    ? ColorManager.white
                    : _textInputFieldController.text.trim().isEmpty
                        ? ColorManager.grey
                        : ColorManager.white,
              ),
              onPressed: () => _sendMessage(),
              icon: widget.isLoading
                  ? const SizedBox(
                      height: 25,
                      width: 25,
                      child: LoadingIndicator(
                        indicatorType: Indicator.lineSpinFadeLoader,
                      ),
                    )
                  : Icon(
                      Icons.arrow_upward_rounded,
                      color: ColorManager.dark,
                      size: 25,
                    ),
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(6),
            child: !widget.isChatHistory
                ? BlocListener<ChatAIBloc, ChatAIState>(
                    bloc: widget.generativeAIBloc,
                    listener: (context, state) {
                      if (state is NewChatSessionCreated) {
                        // showToastFromTop(message: "New chat session created!");
                      }
                      if (state is ChatAIFailure) {
                        // showToastFromTop(
                        //     message: "Failed to create chat session!");
                      }
                    },
                    child: IconButton(
                      onPressed: () => widget.generativeAIBloc
                          .add(CreateNewChatSessionEvent()),
                      icon: const Icon(
                        Icons.add,
                        color: ColorManager.white,
                        size: 25,
                      ),
                    ),
                  )
                : null,
          ),
          enabledBorder: context.inputDecoration.border,
          focusedBorder: context.inputDecoration.border,
        ),
      ),
    );
  }
}
