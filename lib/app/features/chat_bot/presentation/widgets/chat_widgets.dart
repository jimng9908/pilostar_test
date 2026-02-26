import 'package:flutter/material.dart';
import 'package:rockstardata_apk/app/features/chat_bot/domain/entities/chat_bot_models.dart';

class BotMessageBubble extends StatelessWidget {
  final ChatMessage message;
  final Function(ChatOption) onOptionSelected;

  const BotMessageBubble({
    super.key,
    required this.message,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child:
                  Icon(Icons.smart_toy_outlined, color: Colors.grey, size: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.text,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    if (message.summary != null) ...[
                      const SizedBox(height: 16),
                      ChatSummaryCard(data: message.summary!),
                    ],
                    if (message.options != null) ...[
                      const SizedBox(height: 16),
                      ...message.options!.map((option) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ChatOptionButton(
                              option: option,
                              onTap: () => onOptionSelected(option),
                            ),
                          )),
                    ],
                    if (message.summary != null) ...[
                      const SizedBox(height: 16),
                      Text(message.summary!.secondaryDescription,
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _FeedbackButton(
                              label: 'Sí', icon: Icons.thumb_up_alt_outlined),
                          const SizedBox(width: 8),
                          _FeedbackButton(
                              label: 'No', icon: Icons.thumb_down_alt_outlined),
                        ],
                      )
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class UserMessageBubble extends StatelessWidget {
  final ChatMessage message;

  const UserMessageBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF6200EE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message.text,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey[300]!),
            ),
            child: const Text('Tú',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}

class ChatOptionButton extends StatelessWidget {
  final ChatOption option;
  final VoidCallback onTap;

  const ChatOptionButton(
      {super.key, required this.option, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: const Color(0xFFD1C4E9)),
        ),
        child: Row(
          children: [
            if (option.icon != null)
              Icon(Icons.ac_unit, size: 18, color: Colors.deepPurple[400]),
            if (option.emoji != null)
              Text(option.emoji!, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.label,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, color: Color(0xFF424242)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatSummaryCard extends StatelessWidget {
  final ChatSummaryData data;

  const ChatSummaryCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF3E5F5).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEDE7F6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                data.value,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4A148C)),
              ),
              const SizedBox(width: 8),
              Text(
                data.percentage,
                style: const TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            data.description,
            style:
                TextStyle(color: Colors.grey[600], fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }
}

class _FeedbackButton extends StatelessWidget {
  final String label;
  final IconData icon;

  const _FeedbackButton({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text(label,
              style: TextStyle(
                  color: Colors.grey[600], fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
