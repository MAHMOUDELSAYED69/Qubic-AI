import 'package:hive_flutter/hive_flutter.dart';

import '../../model/hive.dart';

class HiveDb {
  static final HiveDb _instance = HiveDb._internal();

  factory HiveDb() {
    return _instance;
  }

  HiveDb._internal();

  Future<void> initializeDatabase() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MessageAdapter());
    Hive.registerAdapter(ChatSessionAdapter());

    await Hive.openBox<Message>('messages');
    await Hive.openBox<ChatSession>('chat_sessions');
  }

  Future<void> deleteAndRecreateDatabase() async {
    await Hive.close();
    await Hive.deleteBoxFromDisk('messages');
    await Hive.deleteBoxFromDisk('chat_sessions');

    await initializeDatabase();
  }
}
