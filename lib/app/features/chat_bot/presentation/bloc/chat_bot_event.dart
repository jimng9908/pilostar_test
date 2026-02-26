part of 'chat_bot_bloc.dart';

abstract class ChatBotEvent extends Equatable {
  const ChatBotEvent();

  @override
  List<Object> get props => [];
}

class InitializeChat extends ChatBotEvent {
  const InitializeChat();
}

class SelectOption extends ChatBotEvent {
  final ChatOption option;

  const SelectOption(this.option);

  @override
  List<Object> get props => [option];
}
