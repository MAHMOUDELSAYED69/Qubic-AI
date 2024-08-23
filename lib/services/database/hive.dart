import 'package:hive_flutter/hive_flutter.dart';
part 'hive.g.dart';

@HiveType(typeId: 0)
class Message extends HiveObject {
  @HiveField(0)
  final String uid;
  @HiveField(1)
  final bool isUser;
  @HiveField(2)
  final String message;
  @HiveField(3)
  final String timestamp;

  Message({
    required this.uid,
    required this.isUser,
    required this.message,
    required this.timestamp,
  });
}

class HiveDb {
  static final HiveDb _instance = HiveDb._internal();

  factory HiveDb() {
    return _instance;
  }

  HiveDb._internal();

  Future<void> initializeDatabase() async {
    Hive.registerAdapter(MessageAdapter());
    await Hive.initFlutter();

    await Hive.openBox<Message>('messages');
  }

  Future<void> deleteAndRecreateDatabase() async {
    await Hive.close();
    await Hive.deleteBoxFromDisk('messages');

    await initializeDatabase();
  }
}
