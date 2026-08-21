import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/chat_message.dart';
import 'ai_chat_state.dart';
import '../../data/ai_chat_service.dart';

class AiChatCubit extends Cubit<AiChatState> {
  final AiChatService _aiChatService;
  final List<ChatMessage> _messages = [];

  AiChatCubit(this._aiChatService) : super(AiChatInitial());

  void sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    final userMessage = ChatMessage(
      text: text,
      sender: MessageSender.user,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    emit(AiChatLoading(List.from(_messages)));

    try {
      final aiChatResponse = await _aiChatService.sendMessage(text);
      
      final aiMessage = ChatMessage(
        text: aiChatResponse.found 
            ? "I found some news for you:" 
            : (aiChatResponse.message ?? "Sorry, I couldn't find anything."),
        sender: MessageSender.ai,
        timestamp: DateTime.now(),
        aiResponse: aiChatResponse,
      );

      _messages.add(aiMessage);
      emit(AiChatSuccess(List.from(_messages)));
    } catch (e) {
      emit(AiChatError(List.from(_messages), "حصلت مشكلة وأنا بحاول أجيب الخبر. حاول تاني."));
    }
  }
}
