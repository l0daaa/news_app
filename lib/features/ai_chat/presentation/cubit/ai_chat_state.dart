import 'package:equatable/equatable.dart';
import '../../models/chat_message.dart';

abstract class AiChatState extends Equatable {
  const AiChatState();

  @override
  List<Object?> get props => [];
}

class AiChatInitial extends AiChatState {}

class AiChatLoading extends AiChatState {
  final List<ChatMessage> messages;
  const AiChatLoading(this.messages);

  @override
  List<Object?> get props => [messages];
}

class AiChatSuccess extends AiChatState {
  final List<ChatMessage> messages;
  const AiChatSuccess(this.messages);

  @override
  List<Object?> get props => [messages];
}

class AiChatError extends AiChatState {
  final List<ChatMessage> messages;
  final String error;
  const AiChatError(this.messages, this.error);

  @override
  List<Object?> get props => [messages, error];
}
