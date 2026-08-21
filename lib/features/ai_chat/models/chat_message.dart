import 'ai_chat_response.dart';

enum MessageSender { user, ai }

class ChatMessage {
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final AiChatResponse? aiResponse; // For rich AI responses

  ChatMessage({
    required this.text,
    required this.sender,
    required this.timestamp,
    this.aiResponse,
  });
}
