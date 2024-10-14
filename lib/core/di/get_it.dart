import 'package:get_it/get_it.dart';
import 'package:qubic_ai/presentation/viewmodel/validation/validation_cubit.dart';

import '../../presentation/viewmodel/chat/chat_bloc.dart';
import '../repositories/message_repository.dart';
import '../services/apis/genetative_ai.dart';
import '../services/database/hivedb.dart';

final getIt = GetIt.instance;

void getItSetup() {
  getIt.registerLazySingleton<GenerativeAIWebService>(
      () => GenerativeAIWebService());
  getIt.registerLazySingleton<HiveDb>(() => HiveDb());

  getIt.registerLazySingleton<MessageRepository>(() => MessageRepository());

  getIt.registerLazySingleton<ValidationCubit>(() => ValidationCubit());

  getIt.registerFactory<ChatAIBloc>(() => ChatAIBloc(
        getIt<GenerativeAIWebService>(),
        getIt<MessageRepository>(),
      ));
}
