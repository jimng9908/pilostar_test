import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rockstardata_apk/app/features/chat_bot/domain/entities/chat_bot_models.dart';

part 'chat_bot_event.dart';
part 'chat_bot_state.dart';

class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc() : super(const ChatBotInitial()) {
    on<InitializeChat>(_onInitializeChat);
    on<SelectOption>(_onSelectOption);
    add(const InitializeChat());
  }

  void _onInitializeChat(InitializeChat event, Emitter<ChatBotState> emit) {
    const initialMessage = ChatMessage(
      id: '1',
      text:
          'Hola, soy tu asistente de Pilotstar. ¿Sobre qué área quieres consultar hoy?',
      type: ChatMessageType.bot,
      options: [
        ChatOption(label: 'Ventas', emoji: '💰', action: 'sales'),
        ChatOption(label: 'Personal', emoji: '👥', action: 'staff'),
        ChatOption(label: 'Reservas', emoji: '📅', action: 'bookings'),
        ChatOption(label: 'Análisis', emoji: '📈', action: 'analytics'),
      ],
    );
    emit(state.copyWith(messages: [initialMessage]));
  }

  void _onSelectOption(SelectOption event, Emitter<ChatBotState> emit) {
    final userMessage = ChatMessage(
      id: DateTime.now().toString(),
      text: event.option.label,
      type: ChatMessageType.user,
    );

    final currentMessages = List<ChatMessage>.from(state.messages);
    currentMessages.add(userMessage);
    emit(state.copyWith(messages: currentMessages));

    // Handle bot response logic
    _generateBotResponse(event.option, emit);
  }

  void _generateBotResponse(ChatOption option, Emitter<ChatBotState> emit) {
    ChatMessage? response;

    if (option.action == 'sales') {
      response = const ChatMessage(
        id: 'sales_init',
        text: '¿Qué quieres saber de tus ventas?',
        type: ChatMessageType.bot,
        options: [
          ChatOption(
              label: '¿Cómo van las ventas de hoy?', action: 'sales_today'),
          ChatOption(
              label: 'Comparar con la semana pasada', action: 'sales_compare'),
          ChatOption(
              label: '¿Cuál es mi ticket medio?', action: 'sales_ticket'),
          ChatOption(label: 'Ventas por franja horaria', action: 'sales_hours'),
          ChatOption(label: 'Ir a Personal 👥', action: 'staff'),
          ChatOption(label: 'Ir a Reservas 📅', action: 'bookings'),
          ChatOption(label: 'Volver al Inicio 🏠', action: 'home'),
        ],
      );
    } else if (option.action == 'sales_today') {
      response = const ChatMessage(
        id: 'sales_today_result',
        text: 'Llevas acumulado hoy:',
        type: ChatMessageType.bot,
        summary: ChatSummaryData(
          value: '2.847€',
          percentage: '+18% vs ayer',
          description:
              'Llevas facturado 2.847€ hoy (hasta las 18:30). Ayer a esta hora llevabas 2.410€.',
          secondaryDescription: '¿Te ha sido útil esta información?',
        ),
        options: [
          ChatOption(
              label: 'Comparar con la semana pasada', action: 'sales_compare'),
          ChatOption(label: 'Ver por franja horaria', action: 'sales_hours'),
          ChatOption(label: 'Volver a Ventas', action: 'sales'),
        ],
      );
    } else if (option.action == 'home') {
      add(const InitializeChat());
      return;
    }

    if (response != null) {
      final updatedMessages = List<ChatMessage>.from(state.messages)
        ..add(response);
      emit(state.copyWith(messages: updatedMessages));
    }
  }
}
