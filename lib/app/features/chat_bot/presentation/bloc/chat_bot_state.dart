part of 'chat_bot_bloc.dart';

class ChatBotState extends Equatable {
  final List<ChatMessage> messages;

  const ChatBotState({this.messages = const []});

  @override
  List<Object> get props => [messages];

  ChatBotState copyWith({
    List<ChatMessage>? messages,
  }) {
    return ChatBotState(
      messages: messages ?? this.messages,
    );
  }
}

class ChatBotInitial extends ChatBotState {
  const ChatBotInitial({super.messages});
}
