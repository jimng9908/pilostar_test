import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rockstardata_apk/app/features/chat_bot/domain/entities/chat_bot_models.dart';
import 'package:rockstardata_apk/app/features/chat_bot/presentation/bloc/chat_bot_bloc.dart';
import 'package:rockstardata_apk/app/features/chat_bot/presentation/widgets/chat_widgets.dart';

class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBotBloc(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.smart_toy, color: Color(0xFF6200EE)),
            onPressed: () {},
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Asistente Pilotstar',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Métricas precisas al instante',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1.0),
            child: Container(color: Colors.grey[200], height: 1.0),
          ),
        ),
        body: BlocBuilder<ChatBotBloc, ChatBotState>(
          builder: (context, state) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.messages.length,
              itemBuilder: (context, index) {
                final message = state.messages[index];
                if (message.type == ChatMessageType.bot) {
                  return BotMessageBubble(
                    message: message,
                    onOptionSelected: (option) {
                      context.read<ChatBotBloc>().add(SelectOption(option));
                    },
                  );
                } else {
                  return UserMessageBubble(message: message);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
