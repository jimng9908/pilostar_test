import 'package:get_it/get_it.dart';
import 'package:rockstardata_apk/app/features/chat_bot/index.dart';

void initChatInjection(GetIt sl) {
  sl.registerLazySingleton<ChatBotBloc>(() => ChatBotBloc());
}
