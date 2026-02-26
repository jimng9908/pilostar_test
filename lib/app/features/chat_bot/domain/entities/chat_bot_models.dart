import 'package:equatable/equatable.dart';

enum ChatMessageType { bot, user }

class ChatOption extends Equatable {
  final String label;
  final String? icon;
  final String? emoji;
  final dynamic action; // Can be a string or a more complex object

  const ChatOption({
    required this.label,
    this.icon,
    this.emoji,
    this.action,
  });

  @override
  List<Object?> get props => [label, icon, emoji, action];
}

class ChatSummaryData extends Equatable {
  final String value;
  final String percentage;
  final String description;
  final String secondaryDescription;

  const ChatSummaryData({
    required this.value,
    required this.percentage,
    required this.description,
    required this.secondaryDescription,
  });

  @override
  List<Object?> get props =>
      [value, percentage, description, secondaryDescription];
}

class ChatMessage extends Equatable {
  final String id;
  final String text;
  final ChatMessageType type;
  final List<ChatOption>? options;
  final ChatSummaryData? summary;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.type,
    this.options,
    this.summary,
  });

  @override
  List<Object?> get props => [id, text, type, options, summary];
}
