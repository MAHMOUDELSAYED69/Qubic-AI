import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qubic_ai/core/di/get_it.dart';
import 'package:qubic_ai/core/utils/extentions/extentions.dart';
import 'package:qubic_ai/presentation/viewmodel/chat/chat_bloc.dart';

import '../../core/utils/constants/colors.dart';
import '../../core/utils/constants/images.dart';
import 'chat.dart';
import 'history.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _chatAIBloc = getIt<ChatAIBloc>();

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        if (_currentTabIndex == 1) {
          _tabController.index = 0;
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 10,
          bottom: TabBar(
            indicatorColor: ColorManager.white,
            controller: _tabController,
            tabs: [
              _buildTab("Qubic AI", ImageManager.logo),
              _buildTab("History", ImageManager.history),
            ],
          ),
        ),
        body: BlocBuilder<ChatAIBloc, ChatAIState>(
          bloc: _chatAIBloc,
          builder: (context, state) {
            return TabBarView(
              controller: _tabController,
              children: [
                ChatScreen(
                  chatId: _chatAIBloc.getSessionId(),
                  chatAIBloc: _chatAIBloc,
                ),
                HistoryScreen(),
              ],
            );
          },
        ),
      ),
    );
  }

  Tab _buildTab(String title, String icon) {
    return Tab(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(icon, width: 20, height: 20),
          const SizedBox(width: 8),
          Text(title, style: context.textTheme.bodySmall),
        ],
      ),
    );
  }
}
