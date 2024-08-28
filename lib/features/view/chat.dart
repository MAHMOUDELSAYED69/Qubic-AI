import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubic_ai/core/utils/constants/colors.dart';
import 'package:qubic_ai/core/utils/constants/images.dart';
import 'package:qubic_ai/core/utils/helper/snackbar.dart';
import '../viewmodel/chat/chat_bloc.dart';
import '../widgets/build_chat_list_view.dart';
import '../widgets/empty_body.dart';
import '../widgets/floating_action_button.dart';
import '../widgets/input_field.dart';

class ChatScreen extends StatefulWidget {
  final int chatId;
  final bool isChatHistory;
  final ChatAIBloc chatAIBloc;
  const ChatScreen(
      {super.key,
      required this.chatId,
      this.isChatHistory = false,
      required this.chatAIBloc});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late ScrollController _scrollController;

  bool _isButtonVisible = false;
  bool _isLoading = false;
  String prompt = '';

  @override
  void initState() {
    super.initState();
    _chatAIBloc = widget.chatAIBloc;
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      bool isAtBottom = _scrollController.position.pixels <= 100;
      if (!isAtBottom) {
        if (!_isButtonVisible) {
          setState(() {
            _isButtonVisible = true;
          });
        }
      } else {
        if (_isButtonVisible) {
          setState(() {
            _isButtonVisible = false;
          });
        }
      }
    });
  }

  void _scrollToEnd([int? duration]) {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: duration ?? 600),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  late ChatAIBloc _chatAIBloc;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAIBloc, ChatAIState>(
      bloc: _chatAIBloc,
      listener: (context, state) {
        if (state is ChatAILoading) {
          _isLoading = true;
        }
        if (state is ChatAIFailure) {
          _isLoading = false;
          SnackBarManager.snackBar(context, state.error);
        }
        if (state is ChatAIStreaming) {
          _isLoading = true;
          prompt += state.streamedText;
          _scrollToEnd(100);
        }
        if (state is ChatAISuccess) {
          _isLoading = false;
          prompt = "";
          _scrollToEnd(100);
        }
        if (state is NewChatSessionCreated) {
          SnackBarManager.snackBar(
              context, "New Chat Created Successfully!");
        }
      },
      builder: (context, state) {
        final messages = _chatAIBloc.getMessages(widget.chatId);
        final messagesLength =
            state is ChatAIStreaming ? messages.length + 1 : messages.length;
        return Scaffold(
          appBar: widget.isChatHistory
              ? AppBar(
                  title: const Text("Chat History"),
                  centerTitle: true,
                  backgroundColor: ColorManager.purple,
                )
              : null,
          resizeToAvoidBottomInset: false,
          floatingActionButton: _isButtonVisible
              ? BuildFloatingActionButton(onPressed: _scrollToEnd)
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Padding(
              padding: const EdgeInsets.all(5),
              child: messages.isEmpty
                  ? const EmptyBodyCard(
                      image: ImageManager.chat,
                      title: "Start Chatting with Qubic AI.",
                    )
                  : BuildChatListViewBuilder(
                      state: state,
                      scrollController: _scrollController,
                      messagesLength: messagesLength,
                      prompt: prompt,
                      messages: messages)),
          bottomNavigationBar: BuildInputField(
            generativeAIBloc: _chatAIBloc,
            chatId: widget.chatId,
            isChatHistory: widget.isChatHistory,
            isLoading: _isLoading,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
